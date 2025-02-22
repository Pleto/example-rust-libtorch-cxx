#!/bin/bash
set -e

LIBTORCH_DIR=${1:-"libtorch"}  # Default installation directory
PYTORCH_REPO="https://github.com/pytorch/pytorch.git"
PYTORCH_BRANCH="main"
BUILD_TYPE="Release"
USE_MPS=ON
NUM_CORES=$(nproc)
TMP_DIR="tmp"

if [ ! -d "${TMP_DIR}" ]; then
    mkdir -p $TMP_DIR
fi

echo "Cloning PyTorch repository..."
if [ ! -d "${TMP_DIR}/pytorch" ]; then
    git clone --recursive -b $PYTORCH_BRANCH --depth 1 $PYTORCH_REPO ${TMP_DIR}/pytorch
else
    echo "PyTorch repository already exists. Skipping clone."
fi

echo "Setting up build and install directories..."
mkdir -p ${TMP_DIR}/pytorch-build $LIBTORCH_DIR

echo "Configuring CMake for LibTorch build..."
cd ${TMP_DIR}/pytorch-build
cmake -DBUILD_SHARED_LIBS=ON \
      -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
      -DUSE_MPS=$USE_MPS \
      -DBUILD_TEST=OFF \
      -DBUILD_PYTHON=OFF \
      -DCMAKE_OSX_ARCHITECTURES=arm64 \
      -DCMAKE_INSTALL_PREFIX=$(realpath ../../$LIBTORCH_DIR) \
      ../pytorch

echo "Building and installing LibTorch..."
cmake --build . --target install -- -j$NUM_CORES

echo "Cleaning up intermediate build files..."
cd ../..
rm -rf ${TMP_DIR}/pytorch-build

echo "LibTorch has been installed in the '$LIBTORCH_DIR' directory."