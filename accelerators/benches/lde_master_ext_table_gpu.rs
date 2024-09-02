use std::time::Duration;

use accelerators::kernels::gpu_parallel::*;
use accelerators::kernels::LDE_gpu_kernel::*;
use criterion::{criterion_group, criterion_main, BenchmarkId, Criterion};

extern crate triton_vm;
use triton_vm::prelude::*;    
use triton_vm::profiler;
use triton_vm::proof_stream;
use triton_vm::proof_item;
use triton_vm::table::master_table::*;
use triton_vm::table::challenges::*;

const POWERS_OF_TWO: u32 = 2;


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