#[cxx::bridge]
pub mod ffi {
    unsafe extern "C++" {
        include!("libtorch.h");

        type Tensor;

        fn is_mps_available() -> bool;
        fn create_tensor_on_mps() -> UniquePtr<Tensor>;
        fn tensor_to_string(_: &Tensor) -> UniquePtr<CxxString>;
    }
}

use cxx::UniquePtr;
use std::fmt;

pub struct MpsTensor {
    tensor: UniquePtr<ffi::Tensor>,
}

impl MpsTensor {
    pub fn new() -> Self {
        MpsTensor {
            tensor: ffi::create_tensor_on_mps()
        }
    }
}

impl fmt::Display for MpsTensor {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        let tensor_ref = self.tensor.as_ref().expect("Tensor is null");
        let s = ffi::tensor_to_string(tensor_ref);
        write!(f, "{}", s)
    }
}