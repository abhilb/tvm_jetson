FROM --platform=linux/arm64 nvcr.io/nvidia/l4t-cuda:10.2.460-runtime

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y -qq && apt-get install -y python3-setuptools \
            gcc \
            libtinfo-dev \
            zlib1g-dev \
            build-essential \
            cmake \
            libedit-dev \
            libxml2-dev \
            git \
            cmake \
            llvm-10 \
            libopenblas-dev \
            libopencv-dev \
            vim \
            libprotobuf-dev \
            protobuf-compiler

RUN ln -s /usr/local/cuda-10.2/targets/aarch64-linux/lib/stubs/libcuda.so /usr/local/cuda-10.2/lib64/libcuda.so

RUN ln -s /usr/local/cuda-10.2/lib64/libcudart.so.10.2 /usr/local/cuda-10.2/lib64/libcudart.so

COPY ./config.cmake .

RUN apt-get install -y python3.8 python3.8-dev

RUN rm /usr/bin/python3

RUN ln -s /usr/bin/python3.8 /usr/bin/python3

RUN apt-get install -y python3-pip python3-setuptools

RUN python3 -m pip install --upgrade pip

RUN python3 -m pip install cython pybind11 numpy

RUN python3 -m pip install attrs \
                           cloudpickle \
                           decorator \
                           psutil \
                           synr \
                           tornado \
                           scipy

RUN mkdir -p /wheels

COPY ./build.sh .

RUN chmod +x build.sh

ENTRYPOINT [ "/bin/bash", "build.sh" ]
