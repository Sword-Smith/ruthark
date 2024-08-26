// use std::time::Duration;

// use accelerators::kernels::merkle_tree_gpu_kernel::GpuParallel;
// use criterion::{criterion_group, criterion_main, BenchmarkId, Criterion};
// use twenty_first::shared_math::other::random_elements;
// use twenty_first::shared_math::rescue_prime_digest::Digest;
// use twenty_first::shared_math::rescue_prime_regular::RescuePrimeRegular;
// use twenty_first::util_types::merkle_tree::{CpuParallel, MerkleTree};
// use twenty_first::util_types::merkle_tree_maker::MerkleTreeMaker;

// fn merkle_tree_cpu(c: &mut Criterion) {
//     let mut group = c.benchmark_group("merkle_tree_cpu");

//     let exponent = 10;
//     let size = usize::pow(2, exponent);
//     group.sample_size(10);
//     group.measurement_time(Duration::from_secs(100));

//     let elements: Vec<Digest> = random_elements(size);

//     group.bench_function(BenchmarkId::new("merkle_tree", size), |bencher| {
//         bencher.iter(|| -> MerkleTree<RescuePrimeRegular, CpuParallel> {
//             CpuParallel::from_digests(&elements[..])
//         });
//     });
// }

// fn merkle_tree_gpu(c: &mut Criterion) {
//     let mut group = c.benchmark_group("merkle_tree_gpu");

//     let exponent = 10;
//     let size = usize::pow(2, exponent);
//     group.sample_size(10);
//     group.measurement_time(Duration::from_secs(100));

//     let elements: Vec<Digest> = random_elements(size);

//     group.bench_function(BenchmarkId::new("merkle_tree", size), |bencher| {
//         bencher.iter(|| -> MerkleTree<RescuePrimeRegular, GpuParallel> {
//             GpuParallel::from_digests(&elements[..])
//         });
//     });
// }
// criterion_group!(benches, merkle_tree_cpu, merkle_tree_gpu);
// criterion_main!(benches);
