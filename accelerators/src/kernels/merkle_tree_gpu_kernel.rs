use gpu_accelerator::{Array_u64_2d, Array_u64_3d, Array_i64_1d, FutharkContext}; // <-- Library must be generated for this to import
use super::gpu_parallel::GpuParallel;

extern crate triton_vm;
use triton_vm::prelude::*;    
use triton_vm::table::master_table::*;
use triton_vm::twenty_first::util_types::merkle_tree::*;
use std::error::Error;


impl GpuParallel {  

    #[allow(dead_code)]
    fn from_digests_tip5_kernel(leafs: &[Digest]) -> Result<Vec<Digest>, Box<dyn Error>>{
        let mut ctx = FutharkContext::new()?;

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

    #[allow(dead_code)]
    fn authentication_structure_kernel(
        merkle_tree: MerkleTree, 
        leaf_indices: &[usize]
    ) -> Result<Vec<Digest>, Box<dyn Error>> {

        let mut ctx = FutharkContext::new()?;

        // Flatten digests into u64 vec
        let flat_nodes_u64: Vec<u64> = merkle_tree.nodes().iter().flat_map(|digest| digest.0.iter())
                                    .map(|bfe| bfe.raw_u64()).collect();
        let dim: &[i64] = &[merkle_tree.nodes().len() as i64, Digest::LEN as i64];
        let input_nodes = Array_u64_2d::from_vec(ctx, &flat_nodes_u64, dim)?;
    
        // Convert leaf_indices to Array_i64_1d
        let leaf_indices_i64 = leaf_indices.iter().map(|x| *x as i64).collect::<Vec<i64>>();
        let input_leaf_indices = Array_i64_1d::from_vec(
            ctx, 
            &leaf_indices_i64, 
            &[leaf_indices_i64.len() as i64]
        )?;
    
        // Run futhark kernel
        let result: Array_u64_2d = ctx.authentication_structure_kernel(input_nodes, input_leaf_indices)?;

        // covnert raw output back to digests
        let (flat_u64_result_vec, _) = result.to_vec().unwrap();
        let auth_structure: Vec<Digest> =  flat_u64_result_vec.chunks(Digest::LEN).map(|chunk| {
            // digest u64 vals -> bfe
            let bfe_vec: Vec<BFieldElement> = 
                chunk.into_iter().map(|bfe| BFieldElement::from_raw_u64(*bfe)).collect();
            // new digest
            Digest::new([bfe_vec[0], bfe_vec[1], bfe_vec[2], bfe_vec[3], bfe_vec[4]])
        }).collect();

        Ok(auth_structure)
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
    use rand::{seq::SliceRandom, Rng, SeedableRng};
    use rand_xorshift::XorShiftRng;


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

    // creates arbitrary vec of usize w/ no repeats, of specified size w/ range between 1..upper_limit
    fn arbitrary_leaf_indices(size: usize, upper_limit: usize) -> Vec<usize> {
        let mut rng = XorShiftRng::from_rng(rand::thread_rng()).expect("Failed to initialize RNG");
        let mut numbers: Vec<usize> = (1..upper_limit).map(|x| x as usize).collect();
        numbers.shuffle(&mut rng);
        numbers.truncate(size);
        numbers
    }
    
    #[test]
    fn test_arbitrary_leaf_indices() {
        let size: usize = 20;
        let upper_limit: usize = 64;
        let vec = arbitrary_leaf_indices(size, upper_limit);
        assert_eq!(vec.len(), size);
        assert!(vec.iter().all(|&x| x >= 0 && x < upper_limit));
        assert_eq!(vec.iter().collect::<std::collections::HashSet<_>>().len(), 20);
    }

    #[test]
    fn futhark_authentication_structure_same_as_rust(){

        let upper_limit = 64;

        // multiple checks for same final digest from tip5
        for i in 0..20 {

            // collect digests
            let mut leafs: Vec<Digest> = vec![];
            for j in 0..upper_limit {
                leafs.push(hash_varlen(&[bfe![i + j as u64]]));
            }
            
            // compute digest both in rust and futhark
            let merkle_tree: MerkleTree = MerkleTree::new::<CpuParallel>(&leafs).unwrap(); 

            // get arbitrary leaf indices
            let leaf_indices = &arbitrary_leaf_indices(i as usize, upper_limit);
            
            // compute auth structure on both futhark and rust
            let actual_auth_structure: Vec<Digest> = 
                merkle_tree.authentication_structure(leaf_indices).unwrap();
            let futhark_auth_structure: Vec<Digest> = 
                GpuParallel::authentication_structure_kernel(merkle_tree, leaf_indices).unwrap();

            // check futhark and rust return same value
            for i in 0..actual_auth_structure.len() {
                assert_eq!(actual_auth_structure[i], futhark_auth_structure[i]);
            }
        }
    }
}