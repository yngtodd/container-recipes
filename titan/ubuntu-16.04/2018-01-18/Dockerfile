FROM ubuntu:16.04

COPY titan_lib.tar.gz /titan_lib.tar.gz
COPY bind_mounts.sh /bind_mounts.sh

ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH:-}:/titan_lib:/usr/local/cuda/lib:/usr/local/cuda/lib64
ENV PATH=${PATH:-}:/usr/local/cuda/bin

RUN apt-get update && \
    apt-get install -y software-properties-common wget pkg-config  gcc-4.9 g++-4.9 mpich patchelf && \
    apt-get clean

RUN wget -q http://developer.download.nvidia.com/compute/cuda/7.5/Prod/local_installers/cuda_7.5.18_linux.run && \
    export PERL5LIB=. && \
    sh cuda_7.5.18_linux.run --silent --toolkit --override && \
    rm cuda_7.5.18_linux.run

RUN ln -s /usr/bin/gcc-4.9 /usr/local/cuda/bin/gcc
RUN ln -s /usr/bin/g++-4.9 /usr/local/cuda/bin/g++

RUN /bind_mounts.sh && \
    rm /bind_mounts.sh

RUN tar -xf /titan_lib.tar.gz && \
    rm /titan_lib.tar.gz

RUN patchelf --set-rpath /titan_lib /titan_lib/libmpich_gnu_49.so.3.0.1
RUN patchelf --set-rpath /titan_lib /titan_lib/libmpichcxx_gnu_49.so.3.0.1
RUN patchelf --set-rpath /titan_lib /titan_lib/libfmpich_gnu_49.so.3.0.1

RUN ln -sfn /titan_lib/libmpich_gnu_49.so.3.0.1 /usr/lib/x86_64-linux-gnu/libmpich.so.12.1.0 && \
    ln -sfn /titan_lib/libmpichcxx_gnu_49.so.3.0.1 /usr/lib/x86_64-linux-gnu/libmpichcxx.so.12.1.0 && \
    ln -sfn /titan_lib/libfmpich_gnu_49.so.3.0.1 /usr/lib/x86_64-linux-gnu/libmpichfort.so.12.1.0  && \
    rm /usr/lib/x86_64-linux-gnu/libmpich.a /usr/lib/x86_64-linux-gnu/libmpichcxx.a /usr/lib/x86_64-linux-gnu/libmpichfort.a