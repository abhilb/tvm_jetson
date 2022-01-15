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

RUN cmake .. && make -j

RUN apt-get install python3.8 python3.8-dev

RUN rm /usr/bin/python3

RUN ln -s /usr/bin/python3.8 /usr/bin/python3

RUN python3.8 -m pip install pip

RUN python3.8 -m pip install asn1crypto == 0.24.0 \
    attrs == 21.4.0 \
    cloudpickle == 2.0.0 \
    cryptography == 2.1.4 \
    Cython == 0.29.26 \
    decorator == 5.1.1 \
    idna == 2.6 \
    keyring == 10.6.0 \
    keyrings.alt == 3.0 \
    import numpy as np == 1.22.1 \
    pip == 9.0.1 \
    psutil == 5.9.0 \
    pycrypto == 2.6.1 \
    Pygments == 2.2.0 \
    pygobject == 3.26.1 \
    pyxdg == 0.25 \
    PyYAML == 3.12 \
    SecretStorage == 2.3.1 \
    setuptools == 39.0.1 \
    six == 1.11.0 \
    wheel == 0.30.0 \
    cython

WORKDIR /tvm/python

RUN python3.8 setup.py bdist_wheel

ENTRYPOINT [ "/bin/bash" ]
