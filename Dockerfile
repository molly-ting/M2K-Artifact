FROM nvidia/cuda:12.1.1-cudnn8-devel-ubuntu22.04

# Set timezone environment variable
ENV TZ=America/New_York

# Set DEBIAN_FRONTEND to noninteractive to avoid user prompts during apt-get install
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata

# Configure timezone and clean up
RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get clean

RUN apt-get update && apt-get -y install g++ \
	gcc \
	cmake \
	git \
	ninja-build \
	wget \
	curl \
	lld \
	python3 \
	python3-pip \
	software-properties-common \
	lldb-13 \
	gdb

RUN add-apt-repository universe

RUN apt-get update && apt-get install -y file g++-multilib gcc-multilib libcap-dev libgoogle-perftools-dev libncurses5-dev libsqlite3-dev libtcmalloc-minimal4 unzip graphviz doxygen
RUN pip3 install lit wllvm
RUN apt-get install -y python3-tabulate 

RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|apt-key add -
RUN apt-get install -y clang-13 llvm-13 llvm-13-dev llvm-13-tools

ENV LLVM_DIR=/usr/lib/llvm-13
ENV PATH="$LLVM_DIR/bin:$PATH"

RUN git clone git@github.com:molly-ting/llvm-project.git
WORKDIR '/home/llvm-project'
RUN git checkout signed
RUN mkdir build
WORKDIR '/home/llvm-project/build'
RUN cmake ..
RUN make -j8
ENV SIGNED_CLANG_PATH=/home/llvm-project/build/bin

WORKDIR '/home'
RUN [ ! -d /home/z3 ] && git clone https://github.com/Z3Prover/z3.git
WORKDIR '/home/z3'
RUN python3 scripts/mk_make.py
WORKDIR '/home/z3/build'
RUN make
RUN make install

RUN apt install -y wget gnupg2 curl lsb-release
RUN apt install -y nano

RUN git clone git@github.com:molly-ting/M2K-Artifact.git
WORKDIR '/home/M2K-Artifact'
RUN cmake -S cuKLEE -B cuKLEE/build
RUN cmake --build cuKLEE/build -j8
ENV PATH="/home/M2K-Artifact/cuKLEE/build:$PATH"
