FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y git \
    wget \
    bash \
    cuda-toolkit-10-2 \
    cuda-compiler-10-2 python3 \
    python3-dev \
    python3-setuptools \
    python3-pip \
    libtinfo-dev \
    zlib1g-dev \
    bash \
    build-essential \
    cmake \
    libedit-dev \
    libxml2-dev \
    llvm-12 \
    llvm-12-dev \
    llvm-12-runtime \
    libz-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libopenblas-dev

RUN python3 -m pip install numpy \
    decorator \
    attrs \
    future \
    xgboost \
    wheel \
    cython

RUN wget https://developer.nvidia.com/embedded/dlc/l4t-gcc-toolchain-64-bit-28-3 -O gcc-4.8.5-aarch64.tgz

RUN mkdir cross_compiler && tar xvf gcc-4.8.5-aarch64.tgz -C cross_compiler

RUN mkdir -p work && cd /work

RUN git clone --recursive https://github.com/apache/tvm tvm

RUN mkdir -p /work/tvm/build 

WORKDIR /work/tvm/build

RUN echo "set (USE_LLVM llvm-config-12)\nset (USE_CUDA ON)\nset (USE_CUDNN OFF)\nset (USE_BLAS openblas)" >> config.cmake
RUN cmake -DCMAKE_C_COMPILER="/cross_compiler/install/bin/aarch64-unknown-linux-gnu-gcc" CMAKE_CXX_COMPILER="/cross_compiler/install/bin/aarch64-unknown-linux-gnu-g++" ..
RUN cmake --build . -j 4

WORKDIR /work/tvm/python
RUN python3 setup.py install

ENTRYPOINT [ "/bin/bash" ]