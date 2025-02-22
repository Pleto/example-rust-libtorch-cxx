use example_rust_libtorch_cxx::{ffi, MpsTensor};

fn main() {
    println!("Is MPS available: {}", ffi::is_mps_available());
    println!("{}", MpsTensor::new());
}