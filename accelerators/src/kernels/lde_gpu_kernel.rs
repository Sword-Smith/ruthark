use gpu_accelerator::{FutharkContext, Array_u64_3d, Array_u64_1d}; // <-- Library must be generated for this to import
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

    // encode rust type Array2<XFieldElement> into futhark type [][][]u64
    // works in conjunction with [Array_u64_3d_to_Array2_Xfe]
    #[allow(dead_code)]
    fn array2_xfe_to_array_u64_3d(
        arr: &Array2<XFieldElement>, 
        ctx: FutharkContext
    ) -> Result<Array_u64_3d, Box<dyn Error>> {
        
        // record shape and flatten array
        let rows = arr.nrows();
        let cols = arr.ncols();
        let mut flat_vec = Vec::with_capacity(rows * cols * EXTENSION_DEGREE);
        
        // create flattened vec of u64 w/ xfe at each "3-string" of u64
        for xfe in arr.iter() {
            for bfe in &xfe.coefficients {
                flat_vec.push(bfe.raw_u64());
            }
        }

        // create 3d array from flattened vec
        let dim = [rows as i64, cols as i64, EXTENSION_DEGREE as i64];
        let encoded = Array_u64_3d::from_vec(ctx, &flat_vec, &dim)?;

        Ok(encoded)
    }

    // convert from futhark type [][][]u64 into rust type Array2<XFieldElement>
    // works in conjunction with [Array2_Xfe_to_Array_u64_3d]
    #[allow(dead_code)]
    fn array_u64_3d_to_array2_xfe(
        arr: &Array_u64_3d, 
    ) -> Result<Array2<XFieldElement>,  Box<dyn Error>> {

        // u64 to xfe
        let (xfe_vals, shape) = arr.to_vec()?;
        // map Xfe values to XFieldElement
        let xfe_vec: Vec<XFieldElement> = GpuParallel::u64_vec_to_xfe_vec(&xfe_vals)?;

        // return w/ original shape
        let original = Array2::from_shape_vec((shape[0] as usize, shape[1] as usize), xfe_vec)?;

        Ok(original)
    }

    // vec<u64> to vec<XFieldElement>
    #[allow(dead_code)]
    fn u64_vec_to_xfe_vec(xfe_vals: &Vec<u64>) -> Result<Vec<XFieldElement>, &'static str> {
        if xfe_vals.len() % 3 != 0 {
            return Err("xfe u64 values vec must be a multiple of 3");
        }

        // map Xfe values to XFieldElement
        let xfe_vec: Vec<XFieldElement> = xfe_vals.chunks(3).map(|chunk| {
            // package raw coeffs into Bfe, then into Xfe
            let bfe_vec: Vec<BFieldElement> = 
                chunk.into_iter().map(|bfe| BFieldElement::from_raw_u64(*bfe)).collect();
            XFieldElement { coefficients: [bfe_vec[0], bfe_vec[1], bfe_vec[2]] }
        }).collect();

        Ok(xfe_vec)
    }
    
    // convert from futhark type [][][]u64 into rust type Vec<Polynomial<XFieldElement>>
    #[allow(dead_code)]
    fn array_u64_3d_to_array_xfe_polynomial(
        arr: &Array_u64_3d, 
    ) -> Result <Vec<Polynomial<XFieldElement>>, Box<dyn Error>> {

        // convert to 2d array of XFieldElement
        let xfe_array = GpuParallel::array_u64_3d_to_array2_xfe(arr)?;

        // convert each row to Polynomial<XFieldElement>
        let mut poly_vec: Vec<Polynomial<XFieldElement>> = Vec::with_capacity(xfe_array.nrows());
        for row in xfe_array.outer_iter() {
                let poly = Polynomial { coefficients: row.to_vec(), };
            poly_vec.push(poly);
        }

        Ok(poly_vec)
    }

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

    pub fn master_ext_table_merkle_tree_root_gpu(
        interpolants: Array_u64_3d,
        fri_domain_offset: BFieldElement,
        fri_domain_generator: BFieldElement,
        fri_domain_length: i64,
     ) -> Result<Array_u64_1d, Box<dyn Error>> {

        let mut ctx = FutharkContext::new()?;
        let result = ctx.master_ext_table_merkle_tree_root(
            interpolants,
            fri_domain_offset.raw_u64(),
            fri_domain_generator.raw_u64(),
            fri_domain_length
        )?;
        
        Ok(result)
    }
}   


#[cfg(test)]
pub(crate) mod lde_gpu_tests {
    use super::*;  
    use crate::kernels::shared;
    use std::time::Instant;

    #[test] 
    pub fn test_array2_xfe_to_array_u64_3d_conversion () {

        // run stark prove until right before LDE
        let factorial_program = shared::factorial_program();
        let public_input = PublicInput::from([bfe!(3)]);
        let non_determinism = NonDeterminism::default();
        let master_ext_table: MasterExtTable = 
            shared::prove_until_master_ext_table_lde(factorial_program, public_input, non_determinism);

        // retrieve array 2 from master_ext_table
        let original_table: Array2<XFieldElement> = 
            master_ext_table.randomized_trace_table.clone();
        

        // setup futharl context
        let ctx = FutharkContext::new().unwrap();


        // convert master_ext_table.randomized_trace_table to Array_u64_3d
        let table_as_array2 = GpuParallel::array2_xfe_to_array_u64_3d(
            &original_table, 
            ctx
        ).unwrap();

        // convert back to Array2<XFieldElement>
        let result: Array2<XFieldElement> = GpuParallel::array_u64_3d_to_array2_xfe(
            &table_as_array2
        ).unwrap();

        // compare out with original arr
        assert!(result.dim() == original_table.dim());
        for i in 0..original_table.nrows() {
            for j in 0..original_table.ncols() {
                assert_eq!(result[[i, j]], original_table[[i, j]]);       
            }
        }        
    }

    #[test]
    pub fn test_array_u64_3d_to_array_xfe_polynomial(){
        

        // create 3d array
        let arr_u64_3d = shared::arbitrary_arr_u64_3d();

        // convert to 2d array of XFieldElement
        let xfe_arr_2d = GpuParallel::array_u64_3d_to_array2_xfe(&arr_u64_3d).unwrap();

        // convert to vex of xfe polys
        let xfe_polynomials = GpuParallel::array_u64_3d_to_array_xfe_polynomial(&arr_u64_3d).unwrap();

        // coefficients of each polynomial should be equal to the rows of the 2d array
        for (poly, row) in xfe_polynomials.iter().zip(xfe_arr_2d.outer_iter()) {
            for (coeff, xfe) in poly.coefficients.iter().zip(row.iter()) {
                assert_eq!(coeff, xfe);
            }
        }
    }


    #[test]
    pub fn from_vec_to_vec_doesnt_modify_array(){

        // create 3d array
        let original_array_u64_3d = shared::arbitrary_arr_u64_3d();  
        
        // convert to vec
        let (original_vec, original_shape) = original_array_u64_3d.to_vec().unwrap();

        // convert back to array
        let ctx = FutharkContext::new().unwrap();
        let returned = Array_u64_3d::from_vec(
            ctx,
            &original_vec,
            &original_shape
        ).unwrap();

        // convert back to vec
        let (returned_vec, returned_shape) = returned.to_vec().unwrap();

        // ensure data integrity
        assert_eq!(original_shape, returned_shape);
        for (a, b) in original_vec.iter().zip(returned_vec.iter()) {
            assert_eq!(a, b);
        }
    }


    // test that [][][3]u64 --> [][]XFieldElement --> [][][3]u64 conversion does not modify data
    #[test]
    pub fn test_futhark_array_conversion_do_not_modify_data() {

        // create 3d array
        let mut ctx = FutharkContext::new().unwrap();
        let original = shared::arbitrary_arr_u64_3d();
        let (original_vec, original_shape) = original.to_vec().unwrap();
        
        // send and return  
        let returned = ctx.test_array_conversion_does_not_change_data(original).unwrap();
        let (returned_vec, returned_shape) = returned.to_vec().unwrap();

        // ensure data integrity
        assert_eq!(original_shape, returned_shape);
        for (a, b) in original_vec.iter().zip(returned_vec.iter()) {
            assert_eq!(a, b);
        }
    }

    #[test]
    pub fn test_rust_conversion_then_futhark_conversion_does_not_modify_data() {
        let mut ctx = FutharkContext::new().unwrap();

        // create 3d array
        let original = shared::arbitrary_arr_u64_3d();
        let (original_vec, original_shape) = original.to_vec().unwrap();
            
        // convert to 2d array of XFieldElement
        let xfe_arr_2d = GpuParallel::array_u64_3d_to_array2_xfe(&original).unwrap();

        // from array 2, convert to 3d array
        let u64_arr_3d = GpuParallel::array2_xfe_to_array_u64_3d(&xfe_arr_2d, ctx).unwrap();
        
        // send and return w/ futhark conversions
        let returned_u64_arr_3d = ctx.test_array_conversion_does_not_change_data(u64_arr_3d).unwrap();
        let (returned_vec, returned_shape) = returned_u64_arr_3d.to_vec().unwrap();

        // convert back to Array_u6
        let returned_xfe_arr_2d = GpuParallel::array_u64_3d_to_array2_xfe(&returned_u64_arr_3d).unwrap();

        // ensure data integrity
        assert_eq!(original_shape, returned_shape);
        for (a, b) in original_vec.iter().zip(returned_vec.iter()) {
            assert_eq!(a, b);
        }
    }

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
    pub fn futhark_master_ext_table_merkle_same_as_rust() {

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
        let root: Array_u64_1d = GpuParallel::master_ext_table_merkle_tree_root_gpu(
            interpolant_polynomials, 
            master_ext_table.fri_domain.offset,
            master_ext_table.fri_domain.generator,
            master_ext_table.fri_domain.length as i64
        ).unwrap();
        let (root_vec, _) = root.to_vec().unwrap();        


        // perform lde and merklize w/ rust impl
        master_ext_table.low_degree_extend_all_columns();
        let merkle_tree: MerkleTree = master_ext_table.merkle_tree();
        let root: Digest = merkle_tree.root();

        // verify roots are the same
        for i in 0..root.0.len() {
            assert_eq!( 
                root.0[i].value(),
                root_vec[i]
            )
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