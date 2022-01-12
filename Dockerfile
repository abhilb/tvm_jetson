FROM nvcr.io/nvidia/l4t-cuda:10.2.460-runtime

RUN apt-get update

ENTRYPOINT [ "/bin/bash" ]
