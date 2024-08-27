use gpu_accelerator::FutharkContext;
use super::gpu_parallel::GpuParallel;
extern crate triton_vm;

#[cfg(test)]
pub(crate) mod LDE_gpu_tests {
    use super::GpuParallel;
    use triton_vm::prelude::*;    

    #[test]
    pub fn gpu_kernel_works() {
        let number = 10;
        let number_plus_1 = GpuParallel::test_gpu_kernels(number);
        assert!(number_plus_1 == number + 1);
    }
}
