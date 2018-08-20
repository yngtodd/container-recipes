FROM olcf/titan:ubuntu-16.04_2018-01-18

ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH:-}:/usr/local/cuda/lib:/usr/local/cuda/lib64
ENV PATH=${PATH:-}:/usr/local/cuda/bin:/usr/lib/jvm/jdk1.8.0_152/bin/:/usr/local/bin
ENV JAVA_HOME=/usr/lib/jvm/jdk1.8.0_152

RUN apt update && \
    apt-get install -y software-properties-common && \
    apt-add-repository universe && \
    apt update && \
    apt install -y mpich && \
    apt install -y build-essential wget curl pkg-config libtool autoconf g++ zip zlib1g-dev unzip git && \
    apt install -y python3-numpy python3-scipy python3-dev python3-mpi4py python3-pip python3-setuptools && \
    rm -rf /var/lib/apt/lists/*


RUN wget http://developer.download.nvidia.com/compute/redist/cudnn/v7.2/cudnn-9.1-linux-x64-v7.2.tgz && \
    tar xvzf cudnn-9.1-linux-x64-v7.2.tgz && \
    cp -P cuda/include/cudnn.h /usr/local/cuda/include && \
    cp -P cuda/lib64/libcudnn* /usr/local/cuda/lib64 && \
    chmod a+r /usr/local/cuda/include/cudnn.h/usr/local/cuda/lib64/libcudnn* && \
