fn main() {
    let libtorch_path = std::env::var("LIBTORCH").expect("Set LIBTORCH environment variable");

    println!("cargo:rustc-link-search=native={}/lib", libtorch_path);
    println!("cargo:rustc-link-lib=dylib=torch_cpu");
    println!("cargo:rustc-link-lib=dylib=c10");
    println!("cargo:rustc-link-lib=dylib=c++");
    
    cxx_build::bridge("src/lib.rs")
        .file("csrc/libtorch.cpp")
        .flag("-w")
        .std("c++17")
        .include("csrc")
        .include(format!("{}/include", libtorch_path))
        .include(format!("{}/include/torch/csrc/api/include", libtorch_path))
        .compile("libtorch-rust");

    println!("cargo:rerun-if-changed=src/lib.rs");
    println!("cargo:rerun-if-changed=csrc/libtorch.h");
    println!("cargo:rerun-if-changed=csrc/libtorch.cpp");
}