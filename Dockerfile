FROM --platform=linux/arm64 nvcr.io/nvidia/l4t-cuda:10.2.460-runtime

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y -qq && apt-get install -y python3-setuptools \
            gcc-8 \
            g++-8 \
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
            lsb-release

RUN lsb_release

RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 800

RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 800

RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /usr/share/keyrings/kitware-archive-keyring.gpg >/dev/null

RUN echo 'deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ bionic main' | tee /etc/apt/sources.list.d/kitware.list >/dev/null

RUN apt-get update

RUN apt-get install -y cmake

RUN cmake --version

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

ENTRYPOINT [ "/bin/bash" ]
