# A library for accelerating some Neptune stuff with GPU's via futhark
## How do I use Futhark in Rust?
Ok so you want to create and call GPU code from Rust. It will involve these steps:
0. Aquiring all software dependencies (see the relevant section).
1. Writing a [futhark entry-point](https://futhark.readthedocs.io/en/latest/language-reference.html#entry-points) in a futhark file, such as futhark-library/futhark_source/main.fut.
2. Creating a rust crate with an executable that depends on [genfut](https://github.com/Ulrik-dk/genfut.git), with a main function that calls `genfut()`, such as is done in `futhark-library/src/main.rs`.
3. Run this crate, to generate a library, such as `generated_lib`. This will be generated from wherever the executable is run.
4. Compile the generated library.
5. Import the generated library in your rust project, and use it, as is done in [triton-vm-gpu/../gpu_kernels.rs](https://neptune.builders/ulrik-dk/triton-vm-gpu/src/branch/master/triton-vm/src/table/gpu_kernels.rs)
6. This means creating a FutharkContext, transforming your data into Futhark arrays (the rust class), calling the function in the context, (this will be named after your entrypoint in your `main.fut`). The result will then have to be unpacked awaited, unpacked etc.

## Dependencies
### Futhark
[releases](https://futhark-lang.org/releases/)
clang
TODO
### CUDA
* TODO
arch packages: cuda
environment variables

#### something like this, might be etc instead, depending on your system
export MYCUDAPATH=/opt/cuda
export CPATH=${MYCUDAPATH}/include:$CPATH
export LD_LIBRARY_PATH=${MYCUDAPATH}/lib64/:$LD_LIBRARY_PATH
export LIBRARY_PATH=${MYCUDAPATH}/lib64:$LIBRARY_PATH

### Other
TODO
