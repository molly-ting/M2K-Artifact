# GKLEE build image (per README)
# Note: GKLEE is tested on Ubuntu 20; we use focal to match.
FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    build-essential \
    g++ \
    cmake \
    libboost-all-dev \
    bison \
    flex \
    python2 \
    python2-minimal \
    perl \
    git \
   ca-certificates \
   wget \
   curl \
   patch \
   xz-utils \
    autotools-dev \
 && ln -sf /usr/bin/python2 /usr/bin/python \
 && rm -rf /var/lib/apt/lists/*

# Build GKLEE
WORKDIR /opt
COPY SetupExterns.cmake .
COPY compiler-rt_lib_asan.patch .
RUN git clone https://github.com/Geof23/Gklee --depth 1 \
 && cd Gklee \
 && cp /opt/SetupExterns.cmake cmake/modules/ \
 && mkdir llvm \
 && mv /opt/compiler-rt_lib_asan.patch patch/compiler-rt_lib_asan.patch \
 && mkdir -p build  \
 && cd build \
 && cmake .. \
 && make -j"$(nproc)"


# Environment for running GKLEE
ENV KLEE_HOME_DIR=/opt/Gklee
ENV PATH="${KLEE_HOME_DIR}/bin:${PATH}"


WORKDIR /workspace

CMD ["/bin/bash"]
