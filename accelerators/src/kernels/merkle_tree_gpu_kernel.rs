use gpu_accelerator::{Array_u64_2d, Array_u64_3d, FutharkContext}; // <-- Library must be generated for this to import
use super::gpu_parallel::GpuParallel;

extern crate triton_vm;
use triton_vm::prelude::*;    
use triton_vm::table::master_table::*;
use triton_vm::twenty_first::util_types::merkle_tree::*;
use std::error::Error;


impl GpuParallel {  

    #[allow(dead_code)]
    fn from_digests_tip5_kernel(leafs: &[Digest]) -> Result<Vec<Digest>, Box<dyn Error>>{
        let mut ctx = FutharkContext::new().unwrap();

        // flatten digests into u64 vec
        let flat_digests_u64: Vec<u64> = 
        leafs.iter().flat_map(|digest| digest.0.iter())
                   .map(|bfe| bfe.raw_u64()).collect();

        // to genfut type
        let dim: &[i64] =  &[leafs.len() as i64, Digest::LEN as i64];
        let input = Array_u64_2d::from_vec(ctx, &flat_digests_u64, dim)?;

        // run futhark kernel
        let result = ctx.from_digest_tip5_kernel(input)?;

        // covnert raw output back to digests
        let (flat_u64_result_vec, _) = result.to_vec().unwrap();
        let digests: Vec<Digest> =  flat_u64_result_vec.chunks(Digest::LEN).map(|chunk| {
            // digest u64 vals -> bfe
            let bfe_vec: Vec<BFieldElement> = 
                chunk.into_iter().map(|bfe| BFieldElement::from_raw_u64(*bfe)).collect();
            // new digest
            Digest::new([bfe_vec[0], bfe_vec[1], bfe_vec[2], bfe_vec[3], bfe_vec[4]])
        }).collect();

        Ok(digests)
    }   

}

#[cfg(test)]
pub(crate) mod lde_gpu_tests {
    use super::*;  
    use crate::kernels::shared;
    use std::time::Instant;
    use triton_vm::table::master_table::*;
    use triton_vm::twenty_first::math::b_field_element::*;
    use triton_vm::twenty_first::util_types::algebraic_hasher::*;

    // from twenty_first::util_types::algebraic_hasher
    fn hash_varlen(input: &[BFieldElement]) -> Digest {
        let mut sponge = Tip5::init();
        sponge.pad_and_absorb_all(input);
        let produce: [BFieldElement; RATE] = sponge.squeeze();

        Digest::new((&produce[..Digest::LEN]).try_into().unwrap())
    }


    #[test]
    fn futhark_tip5_from_digests_same_as_rust(){

        // multiple checks for same final digest from tip5
        for i in 0..20 {

            // collect digests
            let mut leafs: Vec<Digest> = vec![];
            for j in 0..64 {
                leafs.push(hash_varlen(&[bfe![i + j as u64]]));
            }
            
            // compute digest both in rust and futhark
            let actual_nodes: Vec<Digest> = MerkleTree::new::<CpuParallel>(&leafs).unwrap().nodes().to_vec();
            let futhark_nodes: Vec<Digest> = GpuParallel::from_digests_tip5_kernel(&leafs).unwrap();
            
            for i in 0..actual_nodes.len() {
                assert_eq!(actual_nodes[i], futhark_nodes[i]);
            }
        }
    }

}