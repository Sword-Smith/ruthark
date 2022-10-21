# A library for accelerating some Neptune stuff with GPU's via futhark
## How do I use Futhark in Rust?
Ok so you want to create and call GPU code from Rust. It will involve these steps:
0. Aquiring all software dependencies (see the relevant section).
1. Writing a [futhark entry-point](https://futhark.readthedocs.io/en/latest/language-reference.html#entry-points) in a futhark file, such as `futhark-library/futhark_source/main.fut`.
2. Creating a rust crate with an executable that depends on [genfut](https://github.com/Ulrik-dk/genfut.git), with a main function that calls `genfut()`, such as is done in `futhark-library/src/main.rs`.
3. Run this crate, to generate a library, such as `generated_lib`. This will be generated from wherever the executable is run.
4. Compile the generated library.
5. Import the generated library in your rust project, and use it, as is done in [triton-vm-gpu/../gpu_kernels.rs](https://neptune.builders/ulrik-dk/triton-vm-gpu/src/branch/master/triton-vm/src/table/gpu_kernels.rs)
6. This means creating a FutharkContext, transforming your data into Futhark arrays (the rust class), calling the function in the context, (this will be named after your entrypoint in your `main.fut`). The result will then have to be unpacked awaited, unpacked etc.

## How do I add a kernel to this project?
0. Write a futhark entry-point you want to call.
1. Compile the whole thing with `make all`.
2. In the rust project where you want to use it, please set the dependency to your local folder, so you don't have to commit and push just to test a build out.
3. Import the generated library in your Cargo.toml.
4. Write your wrapping-code by pattern-matching on the code in [triton-vm-gpu/../gpu_kernels.rs](https://neptune.builders/ulrik-dk/triton-vm-gpu/src/branch/master/triton-vm/src/table/gpu_kernels.rs).

## Dependencies
### Futhark
* [the latest futhark release](https://futhark-lang.org/releases/)
* [futhark dependencies](https://futhark.readthedocs.io/en/latest/installation.html#dependencies)
* clang
### CUDA
* install the cuda package (depending on your distro)
* arch: community/cuda
* find your cuda path, and set it as an environment variable (e.g. in your .bashrc, but you probably have a nicer place to put it)

`export MYCUDAPATH=/opt/cuda`

* put the rest of the path variables there too

`export CPATH=${MYCUDAPATH}/include:$CPATH`

`export LD_LIBRARY_PATH=${MYCUDAPATH}/lib64/:$LD_LIBRARY_PATH`

`export LIBRARY_PATH=${MYCUDAPATH}/lib64:$LIBRARY_PATH`

### ISPC
If you want to use the ISPC backend, which can give some appreciable CPU speedup, you can install the dependency, and use it as your backend in your generators call to `genfut()`. WARNING: Compilation may take a very long time.

* arch: community/ispc
