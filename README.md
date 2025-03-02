# Ruthark: Exploiting the parallelism in Neptune.

## What can this GPU accelerator do?

This repository implements a GPU accelerator written in futhark for Neptune's Triton-VM. The GPU kernels are accessible via rust bindings that can be directly incorporated into the triton-vm prover.

The functionalities implemented include:

- Low degree extension for the MasterBaseTable
- Low degree extension for the MasterExtTable
- Merkle building
- Tip5 hash function


## Repository setup

NOTE: I left this project somewhat abruptly due to an opportunity that came my way, so it’s in a bit of a hacky, but functional, state at the moment. Apologies in advance, the setup is a bit involved and would definitely benefit from some refactoring.

### 1.)
First run ./setup.sh in the root dir. This will do two things. The first is that it will clone a fork of the triton-vm with some slight modifications necessary for testing (it also runs some code gen on the triton-vm repo). Second, It will run the rust-generator crate, which is a member of the ruthark workspace. This will perform rust code generation that will create rust bindings for the futhark GPU kernels located in the fut-src directory. The result will be a crate called gpu-accelerator that contains those bindings.

### 2.) 
Also note that by default the accelerator backend in rust-generator/codegen.rs is set to OpenCL, but you can replace this with Cuda or C depending on your hardware. 


    fn main() {

        genfut(Options {

            name: GENERATED_RUST_MODULE_NAME.to_string(),

            file: std::path::PathBuf::from(FUTHARK_SOURCE_FILE),

            author: "Name <name@example.com>".to_string(),

            version: "0.1.0".to_string(),

            license: "NONE".to_string(),

            description: "Futhark accelerator for Neptune".to_string(),

            backend: Backend::OpenCL, //  <------ or Backend::Cuda or Backend::C

        })

    }


### 3.) 

Once you have the gpu-accelerators crate generated, you need to modify the Cargo.toml file by changing this line:

    members = ["rust-generator"]


To this:

    members  = ["triton-vm", "gpu-accelerator", "accelerators", "rust-generator"]

### 4.) 

Then you should be able to access the GPU kernels from the accelerators crate, which implements an API that can be incorporated into triton-vm. 

Within gpu-accelerators there is a struct called GpuParallel, which implements methods that can directly replace functions in the triton-vm prover. You should be able to run the following functionalities on the GPU:


- low degree extension for the master base table 

- low degree extension for the master extension table 

- Merkle building

- Tip5

### 5.)

If all goes right, all tests should pass when you run *cargo test* in the accelerators directory.

## If you have further issues:

Submit an issue or contact me on telegram @huowli
