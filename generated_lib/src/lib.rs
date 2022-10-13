#![allow(non_upper_case_globals)]
#![allow(non_camel_case_types)]
#![allow(non_snake_case)]
#![allow(unused_parens)]
#![allow(unused_variables)]
#![allow(dead_code)]
#![allow(improper_ctypes)]
#![allow(unused_imports)]
#![allow(clippy::double_parens)]
#![allow(clippy::unnecessary_fold)]

mod arrays;
pub mod bindings;
mod context;
mod traits;

use std::ffi::CStr;
use std::fmt::{Display, Formatter, Result as FmtResult};
use std::os::raw::c_char;
use std::result::Result as StdResult;

pub use crate::arrays::*;
use crate::traits::*;
pub use context::FutharkContext;

#[derive(Debug)]
pub enum Error {
    FutharkError(FutharkError),
    SizeMismatch(usize, usize),
}

type Result<T> = StdResult<T, Error>;

impl From<FutharkError> for Error {
    fn from(err: FutharkError) -> Self {
        Error::FutharkError(err)
    }
}

#[derive(Debug)]
pub struct FutharkError {
    error: String,
}

impl FutharkError {
    pub(crate) fn new(ctx: *mut bindings::futhark_context) -> Self {
        unsafe { Self::_new(bindings::futhark_context_get_error(ctx)) }
    }

    pub(crate) fn _new(err: *mut ::std::os::raw::c_char) -> Self {
        unsafe {
            Self {
                error: CStr::from_ptr(err).to_string_lossy().into_owned(),
            }
        }
    }
}

impl Display for FutharkError {
    fn fmt(&self, f: &mut Formatter<'_>) -> FmtResult {
        write!(f, "{}", self.error)
    }
}

impl std::error::Error for FutharkError {}

impl Display for Error {
    fn fmt(&self, f: &mut Formatter<'_>) -> FmtResult {
        match self {
            Error::FutharkError(ferr) => write!(f, "{}", ferr),
            Error::SizeMismatch(actual, expected) => {
                write!(f, "Size was: {}, expected: {}.", actual, expected)
            },
        }
    }
}

impl std::error::Error for Error {}

impl FutharkContext {
pub fn kernel_histogram(&mut self, in0: Array_u64_2d, in1: Array_u64_3d, in2: Array_u64_2d, in3: Array_u64_2d, in4: Array_i64_1d, ) -> Result<(Array_u64_3d)>
{
let ctx = self.ptr();
unsafe{
_kernel_histogram(ctx, in0.as_raw_mut(), in1.as_raw_mut(), in2.as_raw_mut(), in3.as_raw_mut(), in4.as_raw_mut(), )
}}

pub fn kernel_histogram_with_is(&mut self, in0: Array_u64_2d, in1: Array_u64_3d, in2: Array_u64_2d, in3: Array_u64_2d, in4: Array_i64_1d, in5: Array_i64_1d, ) -> Result<(Array_u64_3d)>
{
let ctx = self.ptr();
unsafe{
_kernel_histogram_with_is(ctx, in0.as_raw_mut(), in1.as_raw_mut(), in2.as_raw_mut(), in3.as_raw_mut(), in4.as_raw_mut(), in5.as_raw_mut(), )
}}

pub fn kernel_padded(&mut self, in0: Array_u64_2d, in1: Array_u64_3d, in2: Array_u64_3d, in3: Array_u64_3d, ) -> Result<(Array_u64_3d)>
{
let ctx = self.ptr();
unsafe{
_kernel_padded(ctx, in0.as_raw_mut(), in1.as_raw_mut(), in2.as_raw_mut(), in3.as_raw_mut(), )
}}

pub fn kernel_segmented_reduce(&mut self, in0: Array_u64_2d, in1: Array_u64_3d, in2: Array_u64_2d, in3: Array_u64_2d, in4: Array_i64_1d, ) -> Result<(Array_u64_3d)>
{
let ctx = self.ptr();
unsafe{
_kernel_segmented_reduce(ctx, in0.as_raw_mut(), in1.as_raw_mut(), in2.as_raw_mut(), in3.as_raw_mut(), in4.as_raw_mut(), )
}}

pub fn kernel_segmented_reduce_with_flags(&mut self, in0: Array_u64_2d, in1: Array_u64_3d, in2: Array_u64_2d, in3: Array_u64_2d, in4: Array_bool_1d, in5: Array_bool_1d, ) -> Result<(Array_u64_3d)>
{
let ctx = self.ptr();
unsafe{
_kernel_segmented_reduce_with_flags(ctx, in0.as_raw_mut(), in1.as_raw_mut(), in2.as_raw_mut(), in3.as_raw_mut(), in4.as_raw_mut(), in5.as_raw_mut(), )
}}

pub fn matmul(&mut self, in0: Array_i32_2d, in1: Array_i32_2d, ) -> Result<(Array_i32_2d)>
{
let ctx = self.ptr();
unsafe{
_matmul(ctx, in0.as_raw_mut(), in1.as_raw_mut(), )
}}

}
unsafe fn _kernel_histogram(ctx: *mut bindings::futhark_context, in0: *const bindings::futhark_u64_2d, in1: *const bindings::futhark_u64_3d, in2: *const bindings::futhark_u64_2d, in3: *const bindings::futhark_u64_2d, in4: *const bindings::futhark_i64_1d, ) -> Result<(Array_u64_3d)> {
let mut raw_out0 = std::ptr::null_mut();

if bindings::futhark_entry_kernel_histogram(ctx, &mut raw_out0, in0, in1, in2, in3, in4, ) != 0 {
return Err(FutharkError::new(ctx).into());}
Ok((Array_u64_3d::from_ptr(ctx, raw_out0)
))
}
unsafe fn _kernel_histogram_with_is(ctx: *mut bindings::futhark_context, in0: *const bindings::futhark_u64_2d, in1: *const bindings::futhark_u64_3d, in2: *const bindings::futhark_u64_2d, in3: *const bindings::futhark_u64_2d, in4: *const bindings::futhark_i64_1d, in5: *const bindings::futhark_i64_1d, ) -> Result<(Array_u64_3d)> {
let mut raw_out0 = std::ptr::null_mut();

if bindings::futhark_entry_kernel_histogram_with_is(ctx, &mut raw_out0, in0, in1, in2, in3, in4, in5, ) != 0 {
return Err(FutharkError::new(ctx).into());}
Ok((Array_u64_3d::from_ptr(ctx, raw_out0)
))
}
unsafe fn _kernel_padded(ctx: *mut bindings::futhark_context, in0: *const bindings::futhark_u64_2d, in1: *const bindings::futhark_u64_3d, in2: *const bindings::futhark_u64_3d, in3: *const bindings::futhark_u64_3d, ) -> Result<(Array_u64_3d)> {
let mut raw_out0 = std::ptr::null_mut();

if bindings::futhark_entry_kernel_padded(ctx, &mut raw_out0, in0, in1, in2, in3, ) != 0 {
return Err(FutharkError::new(ctx).into());}
Ok((Array_u64_3d::from_ptr(ctx, raw_out0)
))
}
unsafe fn _kernel_segmented_reduce(ctx: *mut bindings::futhark_context, in0: *const bindings::futhark_u64_2d, in1: *const bindings::futhark_u64_3d, in2: *const bindings::futhark_u64_2d, in3: *const bindings::futhark_u64_2d, in4: *const bindings::futhark_i64_1d, ) -> Result<(Array_u64_3d)> {
let mut raw_out0 = std::ptr::null_mut();

if bindings::futhark_entry_kernel_segmented_reduce(ctx, &mut raw_out0, in0, in1, in2, in3, in4, ) != 0 {
return Err(FutharkError::new(ctx).into());}
Ok((Array_u64_3d::from_ptr(ctx, raw_out0)
))
}
unsafe fn _kernel_segmented_reduce_with_flags(ctx: *mut bindings::futhark_context, in0: *const bindings::futhark_u64_2d, in1: *const bindings::futhark_u64_3d, in2: *const bindings::futhark_u64_2d, in3: *const bindings::futhark_u64_2d, in4: *const bindings::futhark_bool_1d, in5: *const bindings::futhark_bool_1d, ) -> Result<(Array_u64_3d)> {
let mut raw_out0 = std::ptr::null_mut();

if bindings::futhark_entry_kernel_segmented_reduce_with_flags(ctx, &mut raw_out0, in0, in1, in2, in3, in4, in5, ) != 0 {
return Err(FutharkError::new(ctx).into());}
Ok((Array_u64_3d::from_ptr(ctx, raw_out0)
))
}
unsafe fn _matmul(ctx: *mut bindings::futhark_context, in0: *const bindings::futhark_i32_2d, in1: *const bindings::futhark_i32_2d, ) -> Result<(Array_i32_2d)> {
let mut raw_out0 = std::ptr::null_mut();

if bindings::futhark_entry_matmul(ctx, &mut raw_out0, in0, in1, ) != 0 {
return Err(FutharkError::new(ctx).into());}
Ok((Array_i32_2d::from_ptr(ctx, raw_out0)
))
}


