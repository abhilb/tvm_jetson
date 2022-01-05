FROM nvcr.io/nvidia/l4t-cuda:10.2.460-runtime

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
    software-properties-common \
    unzip

RUN python3 -m pip install numpy \
    decorator \
    attrs \
    future \
    xgboost \
    wheel \
    cython

RUN mkdir -p work 

COPY ./config.cmake /
WORKDIR /work

RUN git clone --recursive https://github.com/apache/tvm /work/tvm
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