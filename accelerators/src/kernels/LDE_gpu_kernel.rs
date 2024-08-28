use gpu_accelerator::FutharkContext;
use super::gpu_parallel::GpuParallel;

extern crate triton_vm;
use triton_vm::prelude::*;    
use triton_vm::profiler;
use triton_vm::proof_stream;
use triton_vm::proof_item;
use triton_vm::table::master_table::*;
use triton_vm::table::challenges::*;


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
    
        // profiler::profiler!(start "Fiat-Shamir: claim" ("hash"));
        let mut proof_stream = proof_stream::ProofStream::new();
        proof_stream.alter_fiat_shamir_state_with(&claim);
        // profiler!(stop "Fiat-Shamir: claim");

        // profiler!(start "derive additional parameters");
        let padded_height = aet.padded_height();
        let max_degree = stark.derive_max_degree(padded_height);
        let fri = stark.derive_fri(padded_height).unwrap();
        let quotient_domain = Stark::quotient_domain(fri.domain, max_degree).unwrap();
        proof_stream.enqueue(proof_item::ProofItem::Log2PaddedHeight(padded_height.ilog2()));
        // profiler!(stop "derive additional parameters");

        // profiler!(start "base tables");
        // profiler!(start "create" ("gen"));
        let mut master_base_table =
            MasterBaseTable::new(&aet, stark.num_trace_randomizers, quotient_domain, fri.domain);
        // profiler!(stop "create");

        // profiler!(start "pad" ("gen"));
        master_base_table.pad();
        // profiler!(stop "pad");

        // profiler!(start "randomize trace" ("gen"));
        master_base_table.randomize_trace();
        // profiler!(stop "randomize trace");

        // profiler!(start "LDE" ("LDE"));
        master_base_table.low_degree_extend_all_columns();
        // profiler!(stop "LDE");

        // profiler!(start "Merkle tree" ("hash"));
        let base_merkle_tree = master_base_table.merkle_tree();
        // profiler!(stop "Merkle tree");

        // profiler!(start "Fiat-Shamir" ("hash"));
        proof_stream.enqueue(proof_item::ProofItem::MerkleRoot(base_merkle_tree.root()));
        let challenges = proof_stream.sample_scalars(Challenges::SAMPLE_COUNT);
        let challenges = Challenges::new(challenges, &claim);
        // profiler!(stop "Fiat-Shamir");

        // profiler!(start "extend" ("gen"));
        let mut master_ext_table = master_base_table.extend(&challenges);
        // profiler!(stop "extend");
        // profiler!(stop "base tables");

        // profiler!(start "ext tables");
        // profiler!(start "randomize trace" ("gen"));
        master_ext_table.randomize_trace();
        // profiler!(stop "randomize trace");

        master_ext_table
    }


    #[test]
    pub fn LDE_gpu_kernel_works() {

        // program + inputs
        let factorial_program = factorial_program();
        let public_input = PublicInput::from([bfe!(1_000)]);
        let non_determinism = NonDeterminism::default();

        // prove until MasterExtensionTable LDE
        let mut master_ext_table = 
            prove_until_MasterExtTable_LDE(factorial_program, public_input, non_determinism);

        // TODO: feed master_ext_table in this state to LDE_gpu_kernel once implemented
        // TODO: and compare with the result of the following line:

        master_ext_table.low_degree_extend_all_columns();
    }
}
