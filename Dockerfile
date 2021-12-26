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

RUN python3 -m pip install numpy \
    decorator \
    attrs \
    future \
    xgboost \
    wheel \
    cython

RUN wget https://developer.nvidia.com/embedded/dlc/l4t-gcc-7-3-1-toolchain-64-bit -O gcc-linaro-7.3.1-2018.05-x86_64_aarch64-linux-gnu.tar.xz
RUN wget https://developer.nvidia.com/embedded/l4t/r32_release_v6.1/jeston_nano/jetson-nano-jp46-sd-card-image.zip
RUN mkdir cross_compiler && tar xvf gcc-linaro-7.3.1-2018.05-x86_64_aarch64-linux-gnu.tar.xz -C cross_compiler
RUN unzip jetson-nano-jp46-sd-card-image.zip
RUN mkdir -p /mnt/jetson
RUN mount -v -o offset=$((512 * 28672)) -t ext4 sd-blob-b01.img /mnt/jetpack 

# RUN mkdir -p work 

# COPY ./config.cmake /
# WORKDIR /work

# RUN git clone --recursive https://github.com/apache/tvm /work/tvm
# RUN mkdir -p /work/tvm/build 
# WORKDIR /work/tvm/build
# RUN cp /config.cmake .

# RUN cmake -DCMAKE_C_COMPILER="/cross_compiler/gcc-linaro-7.3.1-2018.05-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-gcc" \
#           -DCMAKE_CXX_COMPILER="/cross_compiler/gcc-linaro-7.3.1-2018.05-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-g++" \
#           ..

# RUN cmake --build . --parallel 30

# WORKDIR /work/tvm/python

# RUN python3 setup.py install

ENTRYPOINT [ "/bin/bash" ]