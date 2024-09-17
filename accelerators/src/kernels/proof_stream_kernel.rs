use gpu_accelerator::{FutharkContext, Array_u64_1d}; // <-- Library must be generated for this to import
use super::gpu_parallel::GpuParallel;

extern crate triton_vm;
use triton_vm::prelude::*;    
use triton_vm::proof_stream::*;
use triton_vm::proof::*;

use std::error::Error;



impl GpuParallel {

    // kernel to create proof stream and alters fiat shamir state with claim
    pub fn create_proof_stream_and_alter_fiat_shamir_state_with(claim: &Claim) -> Result<Array_u64_1d, Box<dyn Error>> {
        let mut ctx = FutharkContext::new().unwrap();

        // NOTE: currently, the claim is being encoded here, but this could be move the the GPU as well
        let encoded_claim: Array_u64_1d = GpuParallel::bfe_vec_to_array_u64_1d(&claim.encode(), &mut ctx);

        // run futhark kernel
        let output: Array_u64_1d = 
            ctx.create_proof_stream_and_alter_fiat_shamir_state_with_claim_kernel(encoded_claim)?;
        
        Ok(output)
    }
}

#[cfg(test)]
pub(crate) mod proof_stream_tests {
    use super::*;
    // use super::GpuParallel;
    use crate::kernels::shared::{self, factorial_program};

    #[test]
    fn test_create_proof_stream_and_alter_fiat_shamir_state_with_claim() {

        // pre-flight
        let program = factorial_program();
        let public_input = PublicInput::from([bfe!(3)]);
        let non_determinism = NonDeterminism::default();
        let (aet, public_output) = program.trace_execution(public_input.clone(), non_determinism).unwrap();

        // claim 
        let claim = Claim {
            program_digest: program.hash(),
            input: public_input.individual_tokens,
            output: public_output,
        };

        // The default parameters give a (conjectured) security level of 160 bits.
        let stark = Stark::default();

        // fiat shamir claim in futhark
        let futhark_out: Array_u64_1d = 
            GpuParallel::create_proof_stream_and_alter_fiat_shamir_state_with(&claim).unwrap();

        let futhark_sponge_state: [BFieldElement; 16] = 
            GpuParallel::array_u64_1d_to_tip5_state(futhark_out).unwrap();

        // fiat shamir claim in original rust
        let mut proof_stream = ProofStream::new();
        proof_stream.alter_fiat_shamir_state_with(&claim);

        // ensure the states are equal
        assert_eq!(proof_stream.sponge.state, futhark_sponge_state);
    }
}
