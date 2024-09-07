use std::time::Duration;

use accelerators::kernels::gpu_parallel::*;
use accelerators::kernels::shared::*;
use criterion::{criterion_group, criterion_main, BenchmarkId, Criterion};

extern crate triton_vm;
use triton_vm::prelude::*;    
use triton_vm::proof_stream;
use triton_vm::proof_item;
use triton_vm::table::master_table::*;
use triton_vm::table::challenges::*;

const POWERS_OF_TWO: u32 = 2;

// proves factorial program up until master ext table
pub fn setup_bench(exponent: u32) -> MasterExtTable {
    let n = usize::pow(2, exponent);
    let factorial_program = factorial_program();
    let public_input = PublicInput::from([bfe!(n as u64)]);
    let non_determinism = NonDeterminism::default();

    prove_until_master_ext_table_lde(factorial_program, public_input, non_determinism)
}

fn lde_master_ext_table_cpu(c: &mut Criterion) {
    let mut group = c.benchmark_group("lde_master_ext_table_cpu");
    group.sample_size(10);
    group.measurement_time(Duration::from_secs(100));

    // perform benchmark on increasing powers of two
    for exponent in 1..=POWERS_OF_TWO {  
        let size = usize::pow(2, exponent);
        group.bench_with_input(BenchmarkId::new("lde_master_ext_table", size), &size, |bencher, &size| {

            // get master ext table
            let mut master_ext_table = setup_bench(exponent);
            bencher.iter(|| {

                // run LDE on CPU
                master_ext_table.low_degree_extend_all_columns();    

            });
        });
    }

    group.finish();
}

// Run 
fn lde_master_ext_table_gpu(c: &mut Criterion) {
    let mut group = c.benchmark_group("lde_master_ext_table_gpu");
    group.sample_size(10);
    group.measurement_time(Duration::from_secs(100));

    // perform benchmark on increasing powers of two
    for exponent in 1..=POWERS_OF_TWO {  
        let size = usize::pow(2, exponent);
        group.bench_with_input(BenchmarkId::new("lde_master_ext_table", size), &size, |bencher, &size| {

            // get master ext table 
            let master_ext_table = setup_bench(exponent);

            bencher.iter(|| {
                // run lde on the GPU
                GpuParallel::master_ext_table_lde(master_ext_table.clone()).unwrap();
            });
        });
    }

    group.finish();
}

criterion_group!(benches, lde_master_ext_table_cpu, lde_master_ext_table_gpu);
criterion_main!(benches);