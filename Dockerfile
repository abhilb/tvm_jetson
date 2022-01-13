FROM --platform=linux/arm64 nvcr.io/nvidia/l4t-cuda:10.2.460-runtime

RUN apt-get update
RUN apt-get install -y python3 python3-dev python3-setuptools gcc libtinfo-dev zlib1g-dev build-essential cmake libedit-dev libxml2-dev git cmake

RUN git clone --recursive https://github.com/apache/tvm tvm

RUN apt-get install -y llvm-10 libopenblas-dev vim

RUN ln -s /usr/local/cuda-10.2/targets/aarch64-linux/lib/stubs/libcuda.so /usr/local/cuda-10.2/lib64/libcuda.so

RUN ln -s /usr/local/cuda-10.2/lib64/libcudart.so.10.2 /usr/local/cuda-10.2/lib64/libcudart.so

WORKDIR /tvm

RUN mkdir -p build

WORKDIR /tvm/build

COPY ./config.cmake /tvm/build/

RUN cmake .. && make -j 2

ENTRYPOINT [ "/bin/bash" ]
