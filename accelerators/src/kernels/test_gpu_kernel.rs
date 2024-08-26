use gpu_accelerator::{FutharkContext};

#[derive(Debug)]
pub struct GpuParallel;

impl GpuParallel {
    #[allow(dead_code)]
    fn test_gpu_kernels(number: u64) -> u64 {
        let mut ctx = FutharkContext::new().unwrap();
        ctx.test_gpu_kernel(number).unwrap()
    }
}


#[cfg(test)]
pub(crate) mod merkle_tree_gpu_tests {
    use super::GpuParallel;

    #[test]
    pub fn gpu_kernel_works() {
        let number = 10;
        let number_plus_1 = GpuParallel::test_gpu_kernels(number);
        assert!(number_plus_1 == number + 1);
    }
}
