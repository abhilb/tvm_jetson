#!/bin/bash

echo "======================================="
echo "Build the latest version of Apache TVM"
echo "======================================="

git clone --recursive https://github.com/apache/tvm.git

echo "+++++++++++++ Completed cloning apache tvm ++++++++++++++++"

mkdir -p ./tvm/build
ls -l
ls tvm
cp ./config.cmake ./tvm/build

pushd tvm
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
