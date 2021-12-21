FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y git \
    wget \
    bash \
    python3 \
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
    libopenblas-dev \
    software-properties-common

RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin    
RUN mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub
RUN add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"
RUN apt-get update
RUN apt-get -y install cuda

RUN python3 -m pip install numpy \
    decorator \
    attrs \
    future \
    xgboost \
    wheel \
    cython

RUN wget https://developer.nvidia.com/embedded/dlc/l4t-gcc-7-3-1-toolchain-64-bit -O gcc-linaro-7.3.1-2018.05-x86_64_aarch64-linux-gnu.tar.xz

RUN mkdir cross_compiler && tar xvf gcc-linaro-7.3.1-2018.05-x86_64_aarch64-linux-gnu.tar.xz -C cross_compiler

RUN ls /cross_compiler

# RUN mkdir -p work 

# WORKDIR /work

# RUN git clone --recursive https://github.com/apache/tvm tvm

# RUN mkdir -p /work/tvm/build 

# WORKDIR /work/tvm/build

# RUN echo "set (USE_LLVM llvm-config-12)\nset (USE_CUDA ON)\nset (USE_CUDNN OFF)" >> config.cmake
# RUN cmake -DCMAKE_C_COMPILER="/cross_compiler/install/bin/aarch64-unknown-linux-gnu-gcc" -DCMAKE_CXX_COMPILER="/cross_compiler/install/bin/aarch64-unknown-linux-gnu-g++" ..
# RUN cmake --build . -j 4

# WORKDIR /work/tvm/python
# RUN python3 setup.py install

ENTRYPOINT [ "/bin/bash" ]