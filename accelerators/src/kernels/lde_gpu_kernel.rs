use gpu_accelerator::{FutharkContext, Array_u64_3d, Array_u64_2d, Array_u64_1d}; // <-- Library must be generated for this to import
use super::gpu_parallel::GpuParallel;

extern crate triton_vm;
use triton_vm::prelude::*;    
use triton_vm::table::master_table::*;


use triton_vm::twenty_first::math::x_field_element::EXTENSION_DEGREE;
use triton_vm::twenty_first::util_types::merkle_tree::*;
use triton_vm::twenty_first::math::polynomial::*;
use ndarray::Array2;
use std::error::Error;

impl GpuParallel {

    // Recieves MasterExtTable prior to LDE, unpacks it and does conversion, calls LDE_gpu_kernel
    pub fn master_ext_table_lde(master_ext_table: MasterExtTable) -> Result<Array_u64_3d, Box<dyn Error>> {
        let mut ctx = FutharkContext::new()?;

        // create 3d u64 array from flattened vec
        let randomized_trace_domain = GpuParallel::array2_xfe_to_array_u64_3d(
            &master_ext_table.randomized_trace_table, 
            ctx
        )?;

        // call Gpu kernel
        let result = ctx.lde_master_ext_table_kernel(

            // num trace randomizers
            master_ext_table.num_trace_randomizers as i64,  

            // trace domain
            master_ext_table.trace_domain.offset.raw_u64(),
            master_ext_table.trace_domain.generator.raw_u64(),
            master_ext_table.trace_domain.length as i64,

            // randomized trace domain
            master_ext_table.randomized_trace_domain.offset.raw_u64(),
            master_ext_table.randomized_trace_domain.generator.raw_u64(),
            master_ext_table.randomized_trace_domain.length as i64,

            // quotient domain
            master_ext_table.quotient_domain.offset.raw_u64(),
            master_ext_table.quotient_domain.generator.raw_u64(),
            master_ext_table.quotient_domain.length as i64,

            // fri domain
            master_ext_table.fri_domain.offset.raw_u64(),
            master_ext_table.fri_domain.generator.raw_u64(),
            master_ext_table.fri_domain.length as i64,

            // randomized_trace_table
            randomized_trace_domain,
        )?;
        Ok(result)
    }

    // recieves output of master ext table, evluates rows of  
    // fri domain using lde interpolants, hashes each row JIT
    pub fn hash_all_fri_domain_rows_just_in_time_kernel(
        interpolants: Array_u64_3d,
        fri_domain_offset: BFieldElement,
        fri_domain_generator: BFieldElement,
        fri_domain_length: i64,
    ) -> Result<Vec<Digest>, Box<dyn Error>> {

        // run futhark kernel
        let mut ctx = FutharkContext::new()?; 
        let result: Array_u64_2d = ctx.hash_all_fri_domain_rows_just_in_time_kernel(
            interpolants, 
            fri_domain_offset.raw_u64(),
            fri_domain_generator.raw_u64(),
            fri_domain_length
        )?;

        // covnert raw output back to digests
        let (flat_u64_result_vec, _) = result.to_vec()?;
        let digests: Vec<Digest> =  flat_u64_result_vec.chunks(Digest::LEN).map(|chunk| {
            // digest u64 vals -> bfe
            let bfe_vec: Vec<BFieldElement> = 
                chunk.into_iter().map(|bfe| BFieldElement::from_raw_u64(*bfe)).collect();
            // new digest
            Digest::new([bfe_vec[0], bfe_vec[1], bfe_vec[2], bfe_vec[3], bfe_vec[4]])
        }).collect();

        Ok(digests)  
    }

    pub fn master_ext_table_merkle_tree_kernel(
        interpolants: Array_u64_3d,
        fri_domain_offset: BFieldElement,
        fri_domain_generator: BFieldElement,
        fri_domain_length: i64,
     ) -> Result<Vec<Digest>, Box<dyn Error>> {

        // run futhark kernel
        let mut ctx = FutharkContext::new()?; 
        let result: Array_u64_2d = ctx.master_ext_table_merkle_tree_kernel(
            interpolants, 
            fri_domain_offset.raw_u64(),
            fri_domain_generator.raw_u64(),
            fri_domain_length
        )?;

        // covnert raw output back to digests
        let (flat_u64_result_vec, _) = result.to_vec()?;
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

    #[test]
    pub fn futhark_lde_same_as_rust() {

        // program + inputs
        let factorial_program = shared::factorial_program();
        let public_input = PublicInput::from([bfe!(3)]);
        let non_determinism = NonDeterminism::default();

        // run stark prover until right before MasterExtensionTable LDE
        let mut master_ext_table: MasterExtTable = 
            shared::prove_until_master_ext_table_lde(factorial_program, public_input, non_determinism);

        // perform low degree extension using futhark implementation
        let raw_output: Array_u64_3d = 
            GpuParallel::master_ext_table_lde(master_ext_table.clone()).unwrap();

        let interpolant_polynomials = 
                GpuParallel::array_u64_3d_to_array_xfe_polynomial(&raw_output).unwrap();
    

        // perform low degree extension using rust implementation
        master_ext_table.low_degree_extend_all_columns();    
        let rust_interpolant_polys = 
            master_ext_table.interpolation_polynomials.clone().unwrap();
        
        // ensure all columns interpolated
        assert_eq!(
            interpolant_polynomials.len(),
            rust_interpolant_polys.len(), 
            "incorrect number of polynomials from futhark"
        );

        // compare rust and futhark interpolant polynomials
        for (rust_poly, futhark_poly) in rust_interpolant_polys.iter().zip(interpolant_polynomials.iter()) {

            println!("rust poly num coeffs: {:?}", rust_poly.coefficients.len());
            println!("futhark poly num coeffs: {:?}", futhark_poly.coefficients.len());

            // assert same coeff len
            assert_eq!(rust_poly.degree(), futhark_poly.degree());
            assert_eq!(rust_poly, futhark_poly);
        }
    }

    #[test]
    pub fn futhark_hash_all_fri_domains_JIT_same_as_rust(){

        // program + inputs
        let factorial_program = shared::factorial_program();
        let public_input = PublicInput::from([bfe!(3)]);
        let non_determinism = NonDeterminism::default();

        // run stark prover until right before MasterExtensionTable LDE
        let mut master_ext_table: MasterExtTable = 
            shared::prove_until_master_ext_table_lde(factorial_program, public_input, non_determinism);

        // perform low degree extension using futhark implementation
        let interpolant_polynomials: Array_u64_3d = 
            GpuParallel::master_ext_table_lde(master_ext_table.clone()).unwrap();

        // get merkle root
        let futhark_digests: Vec<Digest> = GpuParallel::hash_all_fri_domain_rows_just_in_time_kernel(
            interpolant_polynomials, 
            master_ext_table.fri_domain.offset,
            master_ext_table.fri_domain.generator,
            master_ext_table.fri_domain.length as i64
        ).unwrap();
        
        // perform lde and hashing using rust implementation
        master_ext_table.low_degree_extend_all_columns();  
        let actual_digests: Vec<Digest> = master_ext_table.hash_all_fri_domain_rows_just_in_time();

        // ensure same output
        for i in 0..actual_digests.len() {
            assert_eq!(futhark_digests[i], actual_digests[i]);
        }
    }
    
    #[test]
    pub fn futhark_merkle_tree_same_as_rust() {

        // program + inputs
        let factorial_program = shared::factorial_program();
        let public_input = PublicInput::from([bfe!(3)]);
        let non_determinism = NonDeterminism::default();

        // run stark prover until right before MasterExtensionTable LDE
        let mut master_ext_table: MasterExtTable = 
            shared::prove_until_master_ext_table_lde(factorial_program, public_input, non_determinism);

        // perform low degree extension using futhark implementation
        let interpolant_polynomials: Array_u64_3d = 
            GpuParallel::master_ext_table_lde(master_ext_table.clone()).unwrap();

        // get merkle root
        let futhark_nodes: Vec<Digest> = GpuParallel::master_ext_table_merkle_tree_kernel(
            interpolant_polynomials, 
            master_ext_table.fri_domain.offset,
            master_ext_table.fri_domain.generator,
            master_ext_table.fri_domain.length as i64
        ).unwrap();

        // perform lde and merklize w/ rust impl
        master_ext_table.low_degree_extend_all_columns();
        let merkle_tree: MerkleTree = master_ext_table.merkle_tree();
        let actual_nodes: Vec<Digest> = merkle_tree.nodes().to_vec();

        // verify trees are the same
        for i in 0..actual_nodes.len() {
            assert_eq!(actual_nodes[i], futhark_nodes[i]);
        }
    }
    
    // This test times the entire process of converting rust types to genfut types, running 
    // lde on the GPU, and converting the output returned from the kernel to the GPU back to 
    // rust types.
    #[test]
    pub fn full_process_bench_gpu(){

        let powers_of_two: u64 = 9; // currently factorial(1 << 10) causes ram to overflow

        for n in 0..powers_of_two {

            let input = 1 << n;

            // program + inputs
            let factorial_program = shared::factorial_program();
            let public_input = PublicInput::from([bfe!(input)]);
            let non_determinism = NonDeterminism::default();

            // run stark prover until right before MasterExtensionTable LDE
            let master_ext_table: MasterExtTable = 
                shared::prove_until_master_ext_table_lde(factorial_program, public_input, non_determinism);
            let dim = master_ext_table.clone().randomized_trace_table.dim();

            // perform low degree extension using futhark implementation
            let start = Instant::now();
            let _: Array_u64_3d = 
                GpuParallel::master_ext_table_lde(master_ext_table).unwrap();


            let duration = start.elapsed();

            // print results
            println!("GPU: Factorial(2 ** {}): {} s / {} ms -- randomize_trace_table dim: {:?}", 
                n, 
                duration.as_secs(), 
                duration.as_millis(),
                dim
            );
        }
    }

    // This test prints the times for conversions to and from genfut/futhark types
    // In addition to the raw time it takes to run on the GPU.
    #[test]
    pub fn individual_components_bench_gpu(){

        let powers_of_two: u64 = 9; // currently factorial( 1 << 10 ) causes ram to overflow

        for n in 0..powers_of_two {

            let input = 1 << n;

            // program + inputs
            let factorial_program = shared::factorial_program();
            let public_input = PublicInput::from([bfe!(input)]);
            let non_determinism = NonDeterminism::default();

            // run stark prover until right before MasterExtensionTable LDE
            let master_ext_table: MasterExtTable = 
                shared::prove_until_master_ext_table_lde(factorial_program, public_input, non_determinism);
            let dim = master_ext_table.clone().randomized_trace_table.dim();

            // setup futhark context
            let mut ctx = FutharkContext::new().unwrap();

            // time rust -> genfut type conversion
            let start = Instant::now();
            let randomized_trace_domain = GpuParallel::array2_xfe_to_array_u64_3d(
                &master_ext_table.randomized_trace_table, 
                ctx
            ).unwrap();
            let duration = start.elapsed();
            println!("Randomized Trace Table Conversion to Genfut Types: {} s / {} ms",             
                duration.as_secs(), 
                duration.as_millis()
            );
    
            // call Gpu kernel
            let start = Instant::now();
            let result: Array_u64_3d = ctx.lde_master_ext_table_kernel(
    
                // num trace randomizers
                master_ext_table.num_trace_randomizers as i64,  
    
                // trace domain
                master_ext_table.trace_domain.offset.raw_u64(),
                master_ext_table.trace_domain.generator.raw_u64(),
                master_ext_table.trace_domain.length as i64,
    
                // randomized trace domain
                master_ext_table.randomized_trace_domain.offset.raw_u64(),
                master_ext_table.randomized_trace_domain.generator.raw_u64(),
                master_ext_table.randomized_trace_domain.length as i64,
    
                // quotient domain
                master_ext_table.quotient_domain.offset.raw_u64(),
                master_ext_table.quotient_domain.generator.raw_u64(),
                master_ext_table.quotient_domain.length as i64,
    
                // fri domain
                master_ext_table.fri_domain.offset.raw_u64(),
                master_ext_table.fri_domain.generator.raw_u64(),
                master_ext_table.fri_domain.length as i64,
    
                // randomized_trace_table
                randomized_trace_domain,
            ).unwrap();
            let duration = start.elapsed();
            println!("GPU: Factorial(2 ** {}): {} s / {} ms -- randomize_trace_table dim: {:?}", 
                n, 
                duration.as_secs(), 
                duration.as_millis(),
                dim
            );
    
            // convert to Vec<Polynomial<XFieldElement>>
            let start = Instant::now();
            let interpolant_polynomials = 
                GpuParallel::array_u64_3d_to_array_xfe_polynomial(&result).unwrap();
            let duration = start.elapsed();
            println!("Conversion Back to Rust Types: {} s / {} ms\n",             
                duration.as_secs(), 
                duration.as_millis()
            );
        }
    }

    #[test]
    pub fn bench_cpu(){

        let powers_of_two: u64 = 10;

        for n in 0..powers_of_two {

            let input = 1 << n;

            // program + inputs
            let factorial_program = shared::factorial_program();
            let public_input = PublicInput::from([bfe!(input)]);
            let non_determinism = NonDeterminism::default();

            // run stark prover until right before MasterExtensionTable LDE
            let mut master_ext_table: MasterExtTable = 
                shared::prove_until_master_ext_table_lde(factorial_program, public_input, non_determinism);


            // perform low degree extension using futhark implementation
            let start = Instant::now();
            master_ext_table.low_degree_extend_all_columns();
            let duration = start.elapsed();

            // print results
            println!("CPU: Factorial(2 ** {}): {} s / {} ms -- randomize_trace_table dim: {:?}", 
                n, 
                duration.as_secs(), 
                duration.as_millis(),
                master_ext_table.randomized_trace_table.dim()
            );
        }
    }
}