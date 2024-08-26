extern crate genfut;
use genfut::{genfut, Backend, Options};

const FUTHARK_SOURCE_FILE: &str = "fut-src/main.fut";
const GENERATED_RUST_MODULE_NAME: &str = "gpu-accelerator";

fn main() {
    genfut(Options {
        name: GENERATED_RUST_MODULE_NAME.to_string(),
        file: std::path::PathBuf::from(FUTHARK_SOURCE_FILE),
        author: "Name <name@example.com>".to_string(),
        version: "0.1.0".to_string(),
        license: "NONE".to_string(),
        description: "Futhark accelerator for Neptune".to_string(),
        backend: Backend::OpenCL,
    })
}