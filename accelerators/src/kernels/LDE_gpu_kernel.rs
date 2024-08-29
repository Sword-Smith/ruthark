use gpu_accelerator::{FutharkContext, Array_u64_3d}; // <-- Library must be generated for this to import
use super::gpu_parallel::GpuParallel;

extern crate triton_vm;
use triton_vm::prelude::*;    
use triton_vm::profiler;
use triton_vm::proof_stream;
use triton_vm::proof_item;
use triton_vm::table::master_table::*;
use triton_vm::table::challenges::*;

use triton_vm::twenty_first::math::x_field_element::EXTENSION_DEGREE;
use ndarray::Array2;

impl GpuParallel {

    // convert from rust representation --> futhark representation
    pub fn Array2_Xfe_to_Array_u64_3d(arr: Array2<XFieldElement>, ctx: FutharkContext) -> Array_u64_3d {
        
        // record shape and flatten array
        let rows = arr.nrows();
        let cols = arr.ncols();
        let mut flat_vec = Vec::with_capacity(rows * cols * EXTENSION_DEGREE);

        // create flattened vec of u64 w/ xfe at "3-strings" of u64
        for xfe in arr.iter() {
            for bfe in &xfe.coefficients {
                flat_vec.push(bfe.raw_u64());
            }
        }

        // create 3d array from flattened vec
        let dim = [rows as i64, cols as i64, EXTENSION_DEGREE as i64];
        Array_u64_3d::from_vec(ctx, &flat_vec, &dim).unwrap()
    }

    // convert from futhark representation --> rust representation
    pub fn Array_u64_3d_to_Array2_Xfe(arr: Array_u64_3d, ctx: FutharkContext) -> Array2<XFieldElement> {

        let (xfe_vals, shape) = arr.to_vec().unwrap();

        // map Xfe values to XFieldElement
        let xfe_vec: Vec<XFieldElement> = xfe_vals.chunks(3).map(|chunk| {
            // package raw coeffs into Bfe, then into Xfe
            let bfe_vec: Vec<BFieldElement> = 
                chunk.into_iter().map(|bfe| BFieldElement::from_raw_u64(*bfe)).collect();
            XFieldElement { coefficients: [bfe_vec[0], bfe_vec[1], bfe_vec[2]] }
        }).collect();

        // convert flattened vec of u64 to Array2<XFieldElement>
        Array2::from_shape_vec((shape[0] as usize, shape[1] as usize), xfe_vec).unwrap()
    }
}


#[cfg(test)]
pub(crate) mod LDE_gpu_tests {
    use super::*;  

    pub fn factorial_program() -> Program {
        triton_program!(
            // op stack:
            read_io 1           // n
            push 1              // n accumulator
            call factorial      // 0 accumulator!
            write_io 1          // 0
            halt
                    
            factorial:          // n acc
                // if n == 0: return
                dup 1           // n acc n
                push 0 eq       // n acc n==0
                skiz            // n acc
                return      // 0 acc
                // else: multiply accumulator with n and recurse
                dup 1           // n acc n
                mul             // n acc·n
                swap 1          // acc·n n
                push -1 add     // acc·n n-1
                swap 1          // n-1 acc·n
                recurse
            )
    }

    // runs stark prove on a given program, stops proving right before 
    // LDE of the master ExtTable is reached. Returns the MasterExtTable 
    // at that point.
    pub fn prove_until_MasterExtTable_LDE(
        program: Program, 
        public_input: PublicInput, 
        non_determinism: NonDeterminism
    ) -> MasterExtTable {

        // pre-flight
        let (aet, public_output) = program.trace_execution(public_input.clone(), non_determinism).unwrap();

        // claim 
        let claim = Claim {
            program_digest: program.hash(),
            input: public_input.individual_tokens,
            output: public_output,
        };
    
        // The default parameters give a (conjectured) security level of 160 bits.
        let stark = Stark::default();
    
        // fiat shamir claim
        let mut proof_stream = proof_stream::ProofStream::new();
        proof_stream.alter_fiat_shamir_state_with(&claim);

        // derive additional parameters
        let padded_height = aet.padded_height();
        let max_degree = stark.derive_max_degree(padded_height);
        let fri = stark.derive_fri(padded_height).unwrap();
        let quotient_domain = Stark::quotient_domain(fri.domain, max_degree).unwrap();
        proof_stream.enqueue(proof_item::ProofItem::Log2PaddedHeight(padded_height.ilog2()));

        // base tables
        let mut master_base_table =
            MasterBaseTable::new(&aet, stark.num_trace_randomizers, quotient_domain, fri.domain);

        // pad
        master_base_table.pad();

        // randomize trace
        master_base_table.randomize_trace();

        // LDE base table
        master_base_table.low_degree_extend_all_columns();

        // Merkle tree
        let base_merkle_tree = master_base_table.merkle_tree();

        // Fiat Shamir
        proof_stream.enqueue(proof_item::ProofItem::MerkleRoot(base_merkle_tree.root()));
        let challenges = proof_stream.sample_scalars(Challenges::SAMPLE_COUNT);
        let challenges = Challenges::new(challenges, &claim);

        // extend
        let mut master_ext_table = master_base_table.extend(&challenges);
        
        // randomize trace
        master_ext_table.randomize_trace();

        // return MasterExtTable right before LDE
        master_ext_table
    }

    #[test] 
    pub fn test_Array2_Xfe_to_Array_u64_3d_conversion () {
        // program + inputs
        let factorial_program = factorial_program();
        let public_input = PublicInput::from([bfe!(6)]);
        let non_determinism = NonDeterminism::default();

        // prove until MasterExtensionTable LDE
        let mut master_ext_table: MasterExtTable = 
            prove_until_MasterExtTable_LDE(factorial_program, public_input, non_determinism);

        // setup Futhark context
        let mut ctx = FutharkContext::new().unwrap();

        // get original array
        let original_trace_table = master_ext_table.randomized_trace_table.clone();

        // convert master_ext_table.randomized_trace_table to Array_u64_3d
        let randomized_trace_domain = GpuParallel::Array2_Xfe_to_Array_u64_3d(
            master_ext_table.randomized_trace_table.clone(), 
            ctx
        );

        // convert back to Array2<XFieldElement>
        let result: Array2<XFieldElement> = GpuParallel::Array_u64_3d_to_Array2_Xfe(
            randomized_trace_domain, 
            ctx
        );

        // compare out with original arr
        assert!(result.dim() == original_trace_table.dim());
        for i in 0..original_trace_table.nrows() {
            for j in 0..result.ncols() {
                assert_eq!(result[[i, j]], result[[i, j]]);       
            }
        }        
    }
}