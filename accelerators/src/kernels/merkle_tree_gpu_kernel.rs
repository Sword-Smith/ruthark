// use gpu_accelerator::{Array_u64_2d, FutharkContext};
// use std::marker::PhantomData;
// use twenty_first::shared_math::b_field_element::BFieldElement;
// use twenty_first::shared_math::other::is_power_of_two;
// use twenty_first::shared_math::rescue_prime_digest::Digest;
// use twenty_first::shared_math::rescue_prime_regular::{RescuePrimeRegular, DIGEST_LENGTH};
// use twenty_first::util_types::merkle_tree::MerkleTree;
// use twenty_first::util_types::merkle_tree_maker::MerkleTreeMaker;

// #[derive(Debug)]
// pub struct GpuParallel;

// impl GpuParallel {
//     #[allow(dead_code)]
//     fn root_from_digests(digests: &[Digest]) -> Digest {
//         let mut ctx = FutharkContext::new().unwrap();
//         let dim_x = i64::try_from(digests.len()).unwrap();
//         let dim_y = i64::try_from(DIGEST_LENGTH).unwrap();
//         let leaves_dims = [dim_x, dim_y];

//         let leaves_flat_bfe = digests.iter().flat_map(|digest| digest.values());
//         let leaves_flat_u64: Vec<u64> = leaves_flat_bfe.map(|bfe| bfe.value()).collect();
//         let leaves_flat_fut = Array_u64_2d::from_vec(ctx, &leaves_flat_u64, &leaves_dims).unwrap();

//         let root_u64 = ctx
//             .kernel_merkle_root_2d(leaves_flat_fut)
//             .unwrap()
//             .to_vec()
//             .unwrap()
//             .0
//             .into_iter()
//             .take(DIGEST_LENGTH);

//         let root_bfe: [BFieldElement; DIGEST_LENGTH] = root_u64
//             .map(BFieldElement::new)
//             .collect::<Vec<_>>()
//             .try_into()
//             .unwrap();

//         Digest::new(root_bfe)
//     }
// }

// impl MerkleTreeMaker<RescuePrimeRegular> for GpuParallel {
//     /// Takes an array of digests and builds a MerkleTree over them.
//     /// The digests are used copied over as the leaves of the tree.
//     fn from_digests(digests: &[Digest]) -> MerkleTree<RescuePrimeRegular, GpuParallel> {
//         let leaves_count = digests.len();

//         assert!(
//             is_power_of_two(leaves_count),
//             "Size of input for Merkle tree must be a power of 2"
//         );

//         let mut ctx = FutharkContext::new().unwrap();
//         let dim_x = i64::try_from(digests.len()).unwrap();
//         let dim_y = i64::try_from(DIGEST_LENGTH).unwrap();
//         let leaves_dims = [dim_x, dim_y];

//         let leaves_flat_bfe = digests.iter().flat_map(|digest| digest.values());
//         let leaves_flat_u64: Vec<u64> = leaves_flat_bfe.map(|bfe| bfe.value()).collect();
//         let leaves_flat_fut = Array_u64_2d::from_vec(ctx, &leaves_flat_u64, &leaves_dims).unwrap();

//         let nodes_u64: Vec<u64> = ctx
//             .kernel_merkle_tree_full(leaves_flat_fut)
//             .unwrap()
//             .to_vec()
//             .unwrap()
//             .0;

//         let nodes: Vec<Digest> = nodes_u64
//             .into_iter()
//             .map(BFieldElement::new)
//             .collect::<Vec<_>>()
//             .chunks_exact(DIGEST_LENGTH)
//             .map(|chunk| {
//                 let ch: Digest = chunk.try_into().unwrap();
//                 ch
//             })
//             .collect();

//         MerkleTree {
//             nodes,
//             _hasher: PhantomData,
//             _maker: PhantomData,
//         }
//     }
// }

// #[cfg(test)]
// pub(crate) mod merkle_tree_gpu_tests {
//     use super::GpuParallel;
//     use twenty_first::{
//         shared_math::{
//             other::random_elements, rescue_prime_digest::Digest,
//             rescue_prime_regular::RescuePrimeRegular,
//         },
//         util_types::{
//             merkle_tree::{CpuParallel, MerkleTree},
//             merkle_tree_maker::MerkleTreeMaker,
//         },
//     };

//     #[test]
//     pub fn gpu_cpu_roots_agree_test() {
//         let exponent = 10;
//         let size = usize::pow(2, exponent);
//         let elements: Vec<Digest> = random_elements(size);

//         let cpu_tree: MerkleTree<RescuePrimeRegular, CpuParallel> =
//             CpuParallel::from_digests(&elements[..]);
//         let cpu_root = cpu_tree.get_root();
//         let gpu_root = GpuParallel::root_from_digests(&elements[..]);

//         println!("CPU: {cpu_root}, GPU: {gpu_root}");
//         assert_eq!(cpu_root, gpu_root)
//     }

//     #[test]
//     pub fn gpu_cpu_trees_agree_test() {
//         let exponent = 10;
//         let size = usize::pow(2, exponent);
//         let elements: Vec<Digest> = random_elements(size);

//         let cpu_tree: MerkleTree<RescuePrimeRegular, CpuParallel> =
//             CpuParallel::from_digests(&elements[..]);
//         let cpu_nodes = cpu_tree.nodes;
//         let gpu_tree = GpuParallel::from_digests(&elements[..]);
//         let gpu_nodes = gpu_tree.nodes;

//         assert_eq!(cpu_nodes, gpu_nodes)
//     }
// }
