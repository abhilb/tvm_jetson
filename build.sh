#!/bin/bash

echo "======================================="
echo "Build the latest version of Apache TVM"
echo "======================================="

git clone --recursive https://github.com/apache/tvm.git

echo "+++++++++++++ Completed cloning apache tvm ++++++++++++++++"

ls -l
cp ./config.cmake ./tvm/build

pushd tvm
mkdir -p build
pushd build
cmake ..
make -j 8
popd

echo "======================================="
echo "Build python packages"
echo "======================================="
pushd python
python3 setup.py bdist_wheel
popd

echo "======================================="
echo "Done"
echo "======================================="
