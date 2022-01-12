FROM nvcr.io/nvidia/l4t-cuda:10.2.460-runtime

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y git \
    bash \
    build-essential \
    cmake \
    libtinfo-dev \
    libedit-dev \
    libxml2-dev \
    wget \
    llvm-10 \
    libopenblas-dev \
    zlib1g-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    python3-pip \
    python3.8 \
    unzip

RUN rm /usr/bin/python3
RUN ln -s /usr/bin/python3.8 /usr/bin/python3
RUN python3 -m pip install pip
RUN python3 -m pip install cython wheel
RUN python3 -m pip install numpy decorator attrs future xgboost 
# wget \
# bash \
# libtinfo-dev \
# zlib1g-dev \
# bash \
# build-essential \
# cmake \
# libedit-dev \
# libxml2-dev \
# libz-dev \
# libcurl4-openssl-dev \
# libssl-dev \
# software-properties-common \
# unzip

#RUN python3.8 -m pip install numpy \
#    decorator \
#    attrs \
#    future \
#    xgboost \
#    wheel \
#    cython

RUN mkdir -p work 

COPY ./config.cmake /
WORKDIR /work

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
