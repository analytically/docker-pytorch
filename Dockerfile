FROM nvidia/cuda:8.0-cudnn5-devel

# Pick up some TF dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        libfreetype6-dev \
        libpng12-dev \
        libzmq3-dev \
        libssl-dev \
        pkg-config \
        python3 \
        python3-dev \
        rsync \
        software-properties-common \
        unzip \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Setup python3 as default
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 10

# Install pip for python3
RUN curl -O https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    rm get-pip.py

RUN pip --no-cache-dir install \
        numpy \
        scipy \
        sklearn \
        scikit-image \
        matplotlib

RUN pip install https://s3.amazonaws.com/pytorch/whl/cu80/torch-0.1.7.post2-cp35-cp35m-linux_x86_64.whl
RUN pip install torchvision