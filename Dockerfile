FROM timongentzsch/l4t-ubuntu20-crosscompile:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y -qq && apt-get install -y python3-setuptools \
            libtinfo-dev \
            zlib1g-dev \
            build-essential \
            libedit-dev \
            libxml2-dev \
            git \
            cmake \
            llvm-10 \
            libopenblas-dev \
            libopencv-dev \
            vim \
            libprotobuf-dev \
            protobuf-compiler \
            wget \
            gpg \
            python3-pip


RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /usr/share/keyrings/kitware-archive-keyring.gpg >/dev/null

RUN echo 'deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ bionic main' | tee /etc/apt/sources.list.d/kitware.list >/dev/null

RUN apt-get update && apt-get install -y cmake python3.8 python3.8-dev

RUN ln -s /usr/local/cuda-10.2/targets/aarch64-linux/lib/stubs/libcuda.so /usr/local/cuda-10.2/lib64/libcuda.so

RUN ln -s /usr/local/cuda-10.2/lib64/libcudart.so.10.2 /usr/local/cuda-10.2/lib64/libcudart.so

COPY ./config.cmake .

RUN rm /usr/bin/python3 && ln -s /usr/bin/python3.8 /usr/bin/python3

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

ENTRYPOINT [ "/bin/bash" ]
