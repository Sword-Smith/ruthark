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
use triton_vm::twenty_first::math::polynomial::*;
use ndarray::Array2;
use std::error::Error;

impl GpuParallel {

    // encode rust type Array2<XFieldElement> into futhark type [][][]u64
    // works in conjunction with [Array_u64_3d_to_Array2_Xfe]
    #[allow(dead_code)]
    fn array2_xfe_to_array_u64_3d(
        arr: &Array2<XFieldElement>, 
        ctx: FutharkContext
    ) -> Result<Array_u64_3d, Box<dyn Error>> {
        
        // record shape and flatten array
        let rows = arr.nrows();
        let cols = arr.ncols();
        let mut flat_vec = Vec::with_capacity(rows * cols * EXTENSION_DEGREE);
        
        // create flattened vec of u64 w/ xfe at each "3-string" of u64
        for xfe in arr.iter() {
            for bfe in &xfe.coefficients {
                flat_vec.push(bfe.raw_u64());
            }
        }

        // create 3d array from flattened vec
        let dim = [rows as i64, cols as i64, EXTENSION_DEGREE as i64];
        let encoded = Array_u64_3d::from_vec(ctx, &flat_vec, &dim)?;

        Ok(encoded)
    }

    // convert from futhark type [][][]u64 into rust type Array2<XFieldElement>
    // works in conjunction with [Array2_Xfe_to_Array_u64_3d]
    #[allow(dead_code)]
    fn array_u64_3d_to_array2_xfe(
        arr: &Array_u64_3d, 
    ) -> Result<Array2<XFieldElement>,  Box<dyn Error>> {

        // u64 to xfe
        let (xfe_vals, shape) = arr.to_vec()?;
        // map Xfe values to XFieldElement
        let xfe_vec: Vec<XFieldElement> = GpuParallel::u64_vec_to_xfe_vec(&xfe_vals)?;

        // return w/ original shape
        let original = Array2::from_shape_vec((shape[0] as usize, shape[1] as usize), xfe_vec)?;

        Ok(original)
    }

    // vec<u64> to vec<XFieldElement>
    #[allow(dead_code)]
    fn u64_vec_to_xfe_vec(xfe_vals: &Vec<u64>) -> Result<Vec<XFieldElement>, &'static str> {
        if xfe_vals.len() % 3 != 0 {
            return Err("xfe u64 values vec must be a multiple of 3");
        }

        // map Xfe values to XFieldElement
        let xfe_vec: Vec<XFieldElement> = xfe_vals.chunks(3).map(|chunk| {
            // package raw coeffs into Bfe, then into Xfe
            let bfe_vec: Vec<BFieldElement> = 
                chunk.into_iter().map(|bfe| BFieldElement::from_raw_u64(*bfe)).collect();
            XFieldElement { coefficients: [bfe_vec[0], bfe_vec[1], bfe_vec[2]] }
        }).collect();

        Ok(xfe_vec)
    }
    
    // convert from futhark type [][][]u64 into rust type Vec<Polynomial<XFieldElement>>
    #[allow(dead_code)]
    fn array_u64_3d_to_array_xfe_polynomial(
        arr: &Array_u64_3d, 
    ) -> Result <Vec<Polynomial<XFieldElement>>, Box<dyn Error>> {

        // convert to 2d array of XFieldElement
        let xfe_array = GpuParallel::array_u64_3d_to_array2_xfe(arr)?;

        // convert each row to Polynomial<XFieldElement>
        let mut poly_vec: Vec<Polynomial<XFieldElement>> = Vec::with_capacity(xfe_array.nrows());
        for row in xfe_array.outer_iter() {
                let poly = Polynomial { coefficients: row.to_vec(), };
            poly_vec.push(poly);
        }

        Ok(poly_vec)
    }

    // Recieves MasterExtTable prior to LDE, unpacks it and does conversion, calls LDE_gpu_kernel
    pub fn master_ext_table_lde(master_ext_table: MasterExtTable) -> Result<Vec<Polynomial<XFieldElement>>, Box<dyn Error>> {
        let mut ctx = FutharkContext::new()?;

        // create 3d u64 array from flattened vec
        let randomized_trace_domain = GpuParallel::array2_xfe_to_array_u64_3d(
            &master_ext_table.randomized_trace_table, 
            ctx
        )?;

        // call Gpu kernel
        let result: Array_u64_3d = ctx.lde_master_ext_table_kernel(

            // num trace randomizers
            master_ext_table.num_trace_randomizers as i64,  

            // trace domain
            master_ext_table.trace_domain.offset.raw_u64(),
            master_ext_table.trace_domain.generator.raw_u64(),
            master_ext_table.trace_domain.length as i64,

            // randomized trace domain
            master_ext_table.randomized_trace_domain.offset.raw_u64(),
            master_ext_table.randomized_trace_domain.generator.raw_u64(),
            master_ext_table.randomized_trace_domain.length as i64,

            // quotient domain
            master_ext_table.quotient_domain.offset.raw_u64(),
            master_ext_table.quotient_domain.generator.raw_u64(),
            master_ext_table.quotient_domain.length as i64,

            // fri domain
            master_ext_table.fri_domain.offset.raw_u64(),
            master_ext_table.fri_domain.generator.raw_u64(),
            master_ext_table.fri_domain.length as i64,

            // randomized_trace_table
            randomized_trace_domain,
        )?;

        // convert to Vec<Polynomial<XFieldElement>>
        let interpolant_polynomials = 
            GpuParallel::array_u64_3d_to_array_xfe_polynomial(&result)?;

        Ok(interpolant_polynomials)
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

    fn arbitrary_arr_u64_3d() -> Array_u64_3d {
        let mut ctx = FutharkContext::new().unwrap();
        Array_u64_3d::from_vec(
            ctx,
            &(0..108).collect::<Vec<u64>>(),
            &[6, 6, 3]
        ).unwrap()
    }

    // runs stark prove on a given program, stops proving right before 
    // LDE of the master ExtTable is reached. Returns the MasterExtTable 
    // at that point.
    pub fn prove_until_master_ext_table_lde(
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
    pub fn test_array2_xfe_to_array_u64_3d_conversion () {

        // run stark prove until right before LDE
        let factorial_program = factorial_program();
        let public_input = PublicInput::from([bfe!(3)]);
        let non_determinism = NonDeterminism::default();
        let master_ext_table: MasterExtTable = 
            prove_until_master_ext_table_lde(factorial_program, public_input, non_determinism);

        // retrieve array 2 from master_ext_table
        let original_table: Array2<XFieldElement> = 
            master_ext_table.randomized_trace_table.clone();
        

        // setup futharl context
        let mut ctx = FutharkContext::new().unwrap();


        // convert master_ext_table.randomized_trace_table to Array_u64_3d
        let table_as_array2 = GpuParallel::array2_xfe_to_array_u64_3d(
            &original_table, 
            ctx
        ).unwrap();

        // convert back to Array2<XFieldElement>
        let result: Array2<XFieldElement> = GpuParallel::array_u64_3d_to_array2_xfe(
            &table_as_array2
        ).unwrap();

        // compare out with original arr
        assert!(result.dim() == original_table.dim());
        for i in 0..original_table.nrows() {
            for j in 0..original_table.ncols() {
                assert_eq!(result[[i, j]], original_table[[i, j]]);       
            }
        }        
    }

    #[test]
    pub fn test_array_u64_3d_to_array_xfe_polynomial(){
        
        let mut ctx = FutharkContext::new().unwrap();

        // create 3d array
        let arr_u64_3d = arbitrary_arr_u64_3d();

        // convert to 2d array of XFieldElement
        let xfe_arr_2d = GpuParallel::array_u64_3d_to_array2_xfe(&arr_u64_3d).unwrap();

        // convert to vex of xfe polys
        let xfe_polynomials = GpuParallel::array_u64_3d_to_array_xfe_polynomial(&arr_u64_3d).unwrap();

        // coefficients of each polynomial should be equal to the rows of the 2d array
        for (poly, row) in xfe_polynomials.iter().zip(xfe_arr_2d.outer_iter()) {
            for (coeff, xfe) in poly.coefficients.iter().zip(row.iter()) {
                assert_eq!(coeff, xfe);
            }
        }
    }


    #[test]
    pub fn from_vec_to_vec_doesnt_modify_array(){

        // create 3d array
        let original_array_u64_3d = arbitrary_arr_u64_3d();  
        
        // convert to vec
        let (original_vec, original_shape) = original_array_u64_3d.to_vec().unwrap();

        // convert back to array
        let mut ctx = FutharkContext::new().unwrap();
        let returned = Array_u64_3d::from_vec(
            ctx,
            &original_vec,
            &original_shape
        ).unwrap();

        // convert back to vec
        let (returned_vec, returned_shape) = returned.to_vec().unwrap();

        // ensure data integrity
        assert_eq!(original_shape, returned_shape);
        for (a, b) in original_vec.iter().zip(returned_vec.iter()) {
            assert_eq!(a, b);
        }
    }


    // test that [][][3]u64 --> [][]XFieldElement --> [][][3]u64 conversion does not modify data
    #[test]
    pub fn test_futhark_array_conversion_do_not_modify_data() {

        // create 3d array
        let mut ctx = FutharkContext::new().unwrap();
        let original = arbitrary_arr_u64_3d();
        let (original_vec, original_shape) = original.to_vec().unwrap();
        
        // send and return  
        let returned = ctx.test_array_conversion_does_not_change_data(original).unwrap();
        let (returned_vec, returned_shape) = returned.to_vec().unwrap();

        // ensure data integrity
        assert_eq!(original_shape, returned_shape);
        for (a, b) in original_vec.iter().zip(returned_vec.iter()) {
            assert_eq!(a, b);
        }
    }

    #[test]
    pub fn test_rust_conversion_then_futhark_conversion_does_not_modify_data() {
        let mut ctx = FutharkContext::new().unwrap();

        // create 3d array
        let original = arbitrary_arr_u64_3d();
        let (original_vec, original_shape) = original.to_vec().unwrap();
            
        // convert to 2d array of XFieldElement
        let xfe_arr_2d = GpuParallel::array_u64_3d_to_array2_xfe(&original).unwrap();

        // from array 2, convert to 3d array
        let u64_arr_3d = GpuParallel::array2_xfe_to_array_u64_3d(&xfe_arr_2d, ctx).unwrap();
        
        // send and return w/ futhark conversions
        let returned_u64_arr_3d = ctx.test_array_conversion_does_not_change_data(u64_arr_3d).unwrap();
        let (returned_vec, returned_shape) = returned_u64_arr_3d.to_vec().unwrap();

        // convert back to Array_u6
        let returned_xfe_arr_2d = GpuParallel::array_u64_3d_to_array2_xfe(&returned_u64_arr_3d).unwrap();

        // ensure data integrity
        // assert_eq!(original_shape, returned_shape);
        for (a, b) in original_vec.iter().zip(returned_vec.iter()) {
            assert_eq!(a, b);
        }
    }

    #[test]
    pub fn futhark_lde_is_rust_lde() {

        // program + inputs
        let factorial_program = factorial_program();
        let public_input = PublicInput::from([bfe!(3)]);
        let non_determinism = NonDeterminism::default();

        // run stark prover until right before MasterExtensionTable LDE
        let mut master_ext_table: MasterExtTable = 
            prove_until_master_ext_table_lde(factorial_program, public_input, non_determinism);

        // perform low degree extension using futhark implementation
        let interpolant_polynomials: Vec<Polynomial<XFieldElement>> = 
            GpuParallel::master_ext_table_lde(master_ext_table.clone()).unwrap();

        // perform low degree extension using rust implementation
        master_ext_table.low_degree_extend_all_columns();    
        let rust_interpolant_polys = 
            master_ext_table.interpolation_polynomials.clone().unwrap();
        
        // ensure all columns interpolated
        assert_eq!(
            interpolant_polynomials.len(),
            rust_interpolant_polys.len(), 
            "incorrect number of polynomials from futhark"
        );

        // compare rust and futhark interpolant polynomials
        for (rust_poly, futhark_poly) in rust_interpolant_polys.iter().zip(interpolant_polynomials.iter()) {

            println!("rust poly num coeffs: {:?}", rust_poly.coefficients.len());
            println!("futhark poly num coeffs: {:?}", futhark_poly.coefficients.len());

            // assert same coeff len
            assert_eq!(rust_poly.degree(), futhark_poly.degree());
            assert_eq!(rust_poly, futhark_poly);
        }
    }
}