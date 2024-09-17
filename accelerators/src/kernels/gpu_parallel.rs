use gpu_accelerator::{FutharkContext, Array_u64_3d, Array_u64_2d, Array_u64_1d}; // <-- Library must be generated for this to import

extern crate triton_vm;
use triton_vm::prelude::*;    
use triton_vm::twenty_first::math::x_field_element::EXTENSION_DEGREE;
use triton_vm::twenty_first::math::polynomial::*;
use ndarray::Array2;
use std::error::Error;


/**
 * GpuParallel is a struct with methods for interacting with GPU kernels 
 * written in Futhark. 
 * 
 * The workflow for using GpuParallel from in rust starting from the raw 
 * futhark code is as follows:
 * 
 * First, a .fut file is written tha does the needed computation. There should
 * be and 'entry' point in the .fut file that specifies any i/o needed from/to 
 * rust.
 * 
 * Next, use the genfut (a compiler that generates rust bindings for the futhark)
 * is used to generator a rust library that will interact with futhark code.
 * 
 * After this, the generated library (gpu_accelerator in this case) can be 
 * called from rust.
 * 
 * 
 * Methods in the below implementation are either for testing or converting from 
 * rust types to genfut rust-futahrk interop types.
 */

#[derive(Debug)]
pub struct GpuParallel;

impl GpuParallel {

    // calls a futhark gpu kernel that adds 1 to a number
    #[allow(dead_code)]
    pub fn test_gpu_kernels(number: u64) -> u64 {
        let mut ctx = FutharkContext::new().unwrap();
        ctx.test_gpu_kernel(number).unwrap()
    }


    // encode rust type Array2<BFieldElement> into futhark type [][]u64
    // works in conjunction with [array_u64_2d_to_array2_bfe]
    #[allow(dead_code)]
    pub fn array2_bfe_to_array_u64_2d( 
        arr: &Array2<BFieldElement>, 
        ctx: FutharkContext
    ) -> Result<Array_u64_2d, Box<dyn Error>> {
        
        // record shape and flatten array
        let rows = arr.nrows();
        let cols = arr.ncols();
        let mut flat_vec = Vec::with_capacity(rows * cols);
        
        // create flattened vec of raw bfe u64 vals
        for bfe in arr.iter() {
            flat_vec.push(bfe.raw_u64());
        }

        // create 3d array from flattened vec
        let dim = [rows as i64, cols as i64];
        let encoded = Array_u64_2d::from_vec(ctx, &flat_vec, &dim)?;

        Ok(encoded)
    }

    // convert from futhark type [][]u64 into rust type Array<BFieldElement>
    // works in conjunction with [array2_bfe_to_array_u64_2d]
    #[allow(dead_code)]
    pub fn array_u64_2d_to_array2_bfe(
        arr: &Array_u64_2d, 
    ) -> Result<Array2<BFieldElement>,  Box<dyn Error>> {

        // u64 to bfe
        let (bfe_vals, shape) = arr.to_vec()?;
        let xfe_vec: Vec<BFieldElement> = GpuParallel::u64_vec_to_bfe_vec(&bfe_vals)?;
        let original = Array2::from_shape_vec((shape[0] as usize, shape[1] as usize), xfe_vec)?;

        Ok(original)
    }

    // vec<u64> to vec<BFieldElement>
    #[allow(dead_code)]
    pub fn u64_vec_to_bfe_vec(xfe_vals: &Vec<u64>) -> Result<Vec<BFieldElement>, &'static str> {
        let bfe_vec: Vec<BFieldElement> = 
            xfe_vals.into_iter().map(|b| {BFieldElement::from_raw_u64(*b)}).collect();
        Ok(bfe_vec)
    }

    // encode rust type Array2<XFieldElement> into futhark type [][][]u64
    // works in conjunction with [Array_u64_3d_to_Array2_Xfe]
    #[allow(dead_code)]
    pub fn array2_xfe_to_array_u64_3d(
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
    pub fn array_u64_3d_to_array2_xfe(
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
    pub fn u64_vec_to_xfe_vec(xfe_vals: &Vec<u64>) -> Result<Vec<XFieldElement>, &'static str> {
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
    pub fn array_u64_3d_to_array_xfe_polynomial(
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

    // convert from futhark type [][][]u64 into rust type Vec<Polynomial<XFieldElement>>
    #[allow(dead_code)]
    pub fn array_u64_2d_to_array_bfe_polynomial(
        arr: &Array_u64_2d, 
    ) -> Result <Vec<Polynomial<BFieldElement>>, Box<dyn Error>> {

        // convert to 2d array of XFieldElement
        let bfe_array = GpuParallel::array_u64_2d_to_array2_bfe(arr)?;

        // convert each row to Polynomial<XFieldElement>
        let mut poly_vec: Vec<Polynomial<BFieldElement>> = Vec::with_capacity(bfe_array.nrows());
        for row in bfe_array.outer_iter() {
                let poly = Polynomial { coefficients: row.to_vec(), };
            poly_vec.push(poly);
        }
        
        Ok(poly_vec)
    }

    // bfe vec rust to genfut type
    #[allow(dead_code)]
    pub fn bfe_vec_to_array_u64_1d(input: &[BFieldElement], ctx: &mut FutharkContext) -> Array_u64_1d {
        let input_u64_vec = input.iter().map(|b| b.raw_u64()).collect::<Vec<u64>>();
        Array_u64_1d::from_vec(*ctx, &input_u64_vec, &[input_u64_vec.len() as i64]).unwrap()
    }

    // Array_u64_1d -> [BFieldElement; 16]
    pub fn array_u64_1d_to_tip5_state(arr: Array_u64_1d) -> Result<[BFieldElement; 16], Box<dyn Error>> {

        // to vec
        let (sponge_state_vec_u64, _) = arr.to_vec()?;
        let sponge_state: Vec<BFieldElement> = GpuParallel::u64_vec_to_bfe_vec( &sponge_state_vec_u64 )?;

        // to arr
        assert_eq!(sponge_state.len(), 16);
        let tip5_state = [
            sponge_state[0], sponge_state[1], sponge_state[2], sponge_state[3],
            sponge_state[4], sponge_state[5], sponge_state[6], sponge_state[7], 
            sponge_state[8], sponge_state[9], sponge_state[10], sponge_state[11], 
            sponge_state[12], sponge_state[13], sponge_state[14], sponge_state[15] 
            ];

        Ok(tip5_state)
    }
}


#[cfg(test)]
pub(crate) mod gpu_kernel_tests {
    use super::*;
    // use super::GpuParallel;
    use crate::kernels::shared;
    use triton_vm::table::master_table::*;
    use ndarray::Array2;

    #[test]
    pub fn gpu_kernel_works() {
        let number = 10;
        let number_plus_1 = GpuParallel::test_gpu_kernels(number);
        assert!(number_plus_1 == number + 1);
    }

    #[test]
    pub fn test_can_use_triton_vm_constructs() {

        // The program that is to be run in Triton VM. Written in Triton assembly.
        // The given example program computes the factorial of the public input.
        let factorial_program = triton_program!(
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
            );

            // Note that all arithmetic is in the prime field with 2^64 - 2^32 + 1 elements.
            // The `bfe!` macro is used to create elements of this field.
            let public_input = PublicInput::from([bfe!(1_000)]);

            // The execution of the factorial program is already fully determined by the public input.
            // Hence, in this case, there is no need for specifying non-determinism.
            let non_determinism = NonDeterminism::default();

            // Generate
            //   - the claim for the given program and input, and
            //   - the proof of correct execution.
            //
            // The claim contains the following public information:
            //   - the program's hash digest under hash function Tip5,
            //   - the program's public input, and
            //   - the program's public output.
            //
            // Triton VM is zero-knowledge with respect to almost everything else.
            // The only other piece of revealed information is an upper bound for the number of steps
            // the program was running for.
            //
            // Triton VM's default parameters give a (conjectured) security level of 160 bits.
            let (stark, claim, proof) =
            triton_vm::prove_program(&factorial_program, public_input, non_determinism).unwrap();

            let verdict = triton_vm::verify(stark, &claim, &proof);
            assert!(verdict);

            println!("Successfully verified proof.");
            let claimed_output = claim.output.iter().map(|o| o.value());
            println!("Verifiably correct output:  {claimed_output:?}");

            let conjectured_security_level = stark.security_level;
            println!("Conjectured security level is {conjectured_security_level} bits.");

            let upper_bound_of_execution_steps = proof.padded_height().unwrap();
            println!("Executing the program took at most {upper_bound_of_execution_steps} cycles.");
    }

    #[test]
    pub fn test_array_u64_2d_to_array_bfe_polynomial(){
        

        // create 2d u64 array
        let arr_u64_2d = shared::arbitrary_arr_u64_2d();

        // convert to 2d array of XFieldElement
        let bfe_arr_2d = GpuParallel::array_u64_2d_to_array2_bfe(&arr_u64_2d).unwrap();

        // convert to vex of xfe polys
        let bfe_polynomials = GpuParallel::array_u64_2d_to_array_bfe_polynomial(&arr_u64_2d).unwrap();

        // coefficients of each polynomial should be equal to the rows of the 2d array
        for (poly, row) in bfe_polynomials.iter().zip(bfe_arr_2d.outer_iter()) {
            for (coeff, bfe) in poly.coefficients.iter().zip(row.iter()) {
                assert_eq!(coeff, bfe);
            }
        }
    }

    #[test] 
    pub fn test_array2_bfe_to_array_u64_2d_conversion () {

        // run stark prove until right before LDE
        let factorial_program = shared::factorial_program();
        let public_input = PublicInput::from([bfe!(3)]);
        let non_determinism = NonDeterminism::default();
        let master_base_table: MasterBaseTable = 
            shared::prove_until_master_base_table_lde(factorial_program, public_input, non_determinism);

        // retrieve array 2 from master_ext_table
        let original_table: Array2<BFieldElement> = 
            master_base_table.randomized_trace_table.clone();
        

        // setup futharl context
        let ctx = FutharkContext::new().unwrap();

        // convert master_ext_table.randomized_trace_table to Array_u64_3d
        let table_as_array2 = GpuParallel::array2_bfe_to_array_u64_2d(
            &original_table, 
            ctx
        ).unwrap();

        // convert back to Array2<BFieldElement>
        let result: Array2<BFieldElement> = GpuParallel::array_u64_2d_to_array2_bfe(
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
}
