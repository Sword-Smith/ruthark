#!/bin/bash

# this script gathers packages needed to run this crate. As well, it updates
# the Cargo.toml file once the gpu-accelerator is generated so that  
# meant to be called in root dir 

# get futhark libs
cd fut-src && futhark pkg sync && cd ..

# clone modified version of triton-vm with certain private fields made public for testing
git clone https://github.com/Holindauer/triton-vm.git

# triton-vm setup / code generation
mv triton-vm triton-vm-repository
cd triton-vm-repository
cargo run --bin constraint-evaluation-generator
mv triton-vm ..
cd ..
rm -rf triton-vm-repository

# generate gpu-accelerator library (rust-futhark interop)
cargo run

# Then adjust the memebrs within cargo.toml from:
# members = ["rust-generator"] # for first generation or  
# members  = ["triton-vm", "gpu-accelerator", "accelerators", "rust-generator"] # for once the gpu-accelerator library is generated
