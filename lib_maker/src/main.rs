extern crate genfut;
use genfut::{genfut, Opt};

const FUTHARK_SOURCE_FILE: &str = "futhark_source/lib.fut";
const GENERATED_RUST_MODULE_NAME: &str = "generated_lib";

fn main() {
    genfut(Opt {
        name: GENERATED_RUST_MODULE_NAME.to_string(),
        file: std::path::PathBuf::from(FUTHARK_SOURCE_FILE),
        author: "Name <name@example.com>".to_string(),
        version: "0.1.0".to_string(),
        license: "YOLO".to_string(),
        description: "Futhark matrix multiplication example".to_string(),
    })
}
