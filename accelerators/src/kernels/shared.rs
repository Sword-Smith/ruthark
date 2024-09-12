use gpu_accelerator::{FutharkContext, Array_u64_3d}; // <-- Library must be generated for this to import

extern crate triton_vm;
use triton_vm::prelude::*;    
use triton_vm::proof_stream;
use triton_vm::proof_item;
use triton_vm::table::master_table::*;
use triton_vm::table::challenges::*;


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

pub fn arbitrary_arr_u64_3d() -> Array_u64_3d {
    let ctx = FutharkContext::new().unwrap();
    Array_u64_3d::from_vec(
        ctx,
        &(0..108).collect::<Vec<u64>>(),
        &[6, 6, 3]
    ).unwrap()
}

// runs stark prove on a given program, stops proving right before 
// LDE of the MasterBaseTable is reached. Returns the MasterBaseTable 
// at that point.
pub fn prove_until_master_base_table_lde(
    program: Program, 
    public_input: PublicInput, 
    non_determinism: NonDeterminism
) -> MasterBaseTable {

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

    master_base_table
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