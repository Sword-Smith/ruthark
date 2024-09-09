use gpu_accelerator::{FutharkContext, Array_u64_1d}; // <-- Library must be generated for this to import
use super::gpu_parallel::GpuParallel;

extern crate triton_vm;
use triton_vm::prelude::*;    

use triton_vm::twenty_first::math::b_field_element::*;
use triton_vm::twenty_first::util_types::algebraic_hasher::*;

impl GpuParallel {

    // hashes variable len bfe array w/ tip5 on gpu
    #[allow(dead_code)]
    fn tip5_hash_varlen(input: &[BFieldElement]) -> Digest {

        // conversions
        let mut ctx = FutharkContext::new().unwrap();
        let input_u64_vec = input.iter().map(|b| b.raw_u64()).collect::<Vec<u64>>();
        let input = Array_u64_1d::from_vec(ctx, &input_u64_vec, &[input_u64_vec.len() as i64]).unwrap();

        // run tip5 hash kernel in futhark
        let (digest_u64, _) = ctx.tip5_hash_varlen_kernel(input).unwrap().to_vec().unwrap();
        if digest_u64.len() != 5 {
            panic!("Expected exactly 5 elements for digest computation.");
        }
        
        // package into digest and return
        let digest_array: [BFieldElement; 5] = [
            BFieldElement::from_raw_u64(digest_u64[0]),
            BFieldElement::from_raw_u64(digest_u64[1]),
            BFieldElement::from_raw_u64(digest_u64[2]),
            BFieldElement::from_raw_u64(digest_u64[3]),
            BFieldElement::from_raw_u64(digest_u64[4]),
        ];
        Digest::new(digest_array)
    }

}   


#[cfg(test)]
pub(crate) mod lde_gpu_tests {
    use super::*;  
    use crate::kernels::shared;
    use std::time::Instant;

    // from twenty_first::util_types::algebraic_hasher
    fn hash_varlen(input: &[BFieldElement]) -> Digest {
        let mut sponge = Tip5::init();
        sponge.pad_and_absorb_all(input);
        let produce: [BFieldElement; RATE] = sponge.squeeze();

        Digest::new((&produce[..Digest::LEN]).try_into().unwrap())
    }


    #[test]
    fn test_tip5_hash_varlen_gpu(){

        // multiple checks for same final digest from tip5
        for i in 0..20 {
            let mut input: Vec<BFieldElement> = vec![];
            for j in 0..100 {
    
                input.push(bfe![i + j as u64]);
            }
            
            // compute digest both in rust and futhark
            let actual_digest = hash_varlen(&input);
            let futhark_digest = GpuParallel::tip5_hash_varlen(&input);
    
            assert_eq!(actual_digest, futhark_digest);
        }
    }
}