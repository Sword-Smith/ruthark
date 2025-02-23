# Ruthark: Exploiting the parallelism in Neptune.
## Repository setup
Since we are generating a lot of code, and since we are using git repositories to make this accessible to cargo, we ended up having a balooning repository size. As of late october 2022, this is a quarter of a gigabyte. In order to minimize this, a quick and relatively simple solution is to separate the reposities for the source code and the generated files. So in order to get started, you must:
0. Enter your workspace: `$ cd <your workspace>`
1. Clone this repo: `$ git clone ssh://git@neptune.builders:2222/ulrik-dk/gpu-accelerator.git`
2. Clone the generated repo: `$ git clone ssh://git@neptune.builders:2222/ulrik-dk/ruthark.git`
3. Make sure the symbolic link `ruthark/gpu-accelerator` points to `../gpu-accelerator/`, and that you have cloned this repository.

## How do I add a kernel to this project?
0. Set up the repos. See above.
1. Aquire the software dependencies, see below.
2. Write a futhark entry-point you want to call.
3. Compile the whole thing with `make all`. You can also use `make fast`, as long as you have called `make fu`(or `make all`) once.
4. In the rust project where you want to use the generated code, set the dependency to the path of your generated-code-folder, in your Cargo.toml.
5. Write your wrapping-code by pattern-matching on the code in [triton-vm-gpu/../gpu_kernels.rs](https://neptune.builders/ulrik-dk/triton-vm-gpu/src/branch/master/triton-vm/src/table/gpu_kernels.rs).
6. Once you have something you want to put in a PR, please create branches on the target repo, this repo and the gpu-accelerator repo, and commit the code in all three repos.
## More generally, how do I use Futhark in Rust, if I wanted to start over?
Ok so you want to create and call GPU code from Rust. It will involve these steps:

0. Aquiring all software dependencies (see the relevant section).
1. Writing a [futhark entry-point](https://futhark.readthedocs.io/en/latest/language-reference.html#entry-points) in a futhark file, such as `futhark-library/futhark_source/main.fut`.
2. Creating a rust crate with an executable that depends on [genfut](https://github.com/Ulrik-dk/genfut.git), with a main function that calls `genfut()`, such as is done in `rust-generator/src/main.rs`.
3. Run this crate, to generate a library, such as `gpu-accelerator`. This will be generated from wherever the executable is run.
4. Compile the generated library.
5. Import the generated library in your rust project, and use it, as is done in [triton-vm-gpu/../gpu_kernels.rs](https://neptune.builders/ulrik-dk/triton-vm-gpu/src/branch/master/triton-vm/src/table/gpu_kernels.rs)
6. This means creating a FutharkContext, transforming your data into Futhark arrays (the rust class), calling the function in the context, (this will be named after your entrypoint in your `main.fut`). The result will then have to be unpacked awaited, unpacked etc.
7. Please refer to the readinglist at the end of this README for more information on writing Futhark.

## Installation of dependencies
* Futharks dependencies
* Futhark
* CUDA

### Futhark
Generally: [Futharks own installation instructions](https://futhark.readthedocs.io/en/latest/installation.html)
#### macOS
Futhark is available on Homebrew, and the latest release can be installed via:

`$ brew install futhark`
Or you can install the unreleased development version with:

macOS ships with one OpenCL platform and various devices. One of these devices is always the CPU, which is not fully functional, and is never picked by Futhark by default. You can still select it manually with the usual mechanisms (see Executable Options), but it is unlikely to be able to run most Futhark programs. Depending on the system, there may also be one or more GPU devices, and Futhark will simply pick the first one as always. On multi-GPU MacBooks, this is is the low-power integrated GPU. It should work just fine, but you might have better performance if you use the dedicated GPU instead. On a Mac with an AMD GPU, this is done by passing -dAMD to the generated Futhark executable.

#### Ubuntu
```bash
# Install Futhark (by first installing linuxbrew)
/bin/bash -c "(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add /home/linuxbrew/.linuxbrew/bin to your PATH:
export PATH=/home/linuxbrew/.linuxbrew/bin:$PATH # You should add this to your ~/.bashrc
brew install futhark # No sudo needed!

# Clone repo
$ git clone ssh://git@neptune.builders:2222/ulrik-dk/ruthark.git
 
# Install `libclang-dev`
$ sudo apt-get install libclang-dev

# Run the Futhark program
$ make all
```

#### Arch
* [the latest futhark release](https://futhark-lang.org/releases/)
* [futhark dependencies](https://futhark.readthedocs.io/en/latest/installation.html#dependencies)

In the Makefile, there is a sudo-requiring command that generically installs futhark. It should work for all linux distros.

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

## Futhark readinglist
* [index](https://futhark-lang.org/index.html)
* [Language Reference](https://futhark.readthedocs.io/en/latest/language-reference.html)
* [Futhark Compared to Other Functional Languages](https://futhark.readthedocs.io/en/stable/versus-other-languages.html)
* [Futhark Library Documentation](https://futhark-lang.org/docs/prelude/)
* [Parallel Programming in Futhark](https://futhark-book.readthedocs.io/en/latest/)
* [Writing Fast Futhark Programs](https://futhark.readthedocs.io/en/latest/performance.html)
