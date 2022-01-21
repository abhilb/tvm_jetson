#!/bin/bash
echo "Build the latest version of Apache TVM"
git clone --recursive https://github.com/apache/tvm.git
cd tvm
mkdir -p build
cp config.cmake tvm/build
cmake ..
