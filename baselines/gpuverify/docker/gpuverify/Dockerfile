# GPUVerify Docker Environment
# Based on Ubuntu 22.04 with Mono, Python 3, and all dependencies

FROM ubuntu:22.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    git \
    subversion \
    ca-certificates \
    gnupg \
    software-properties-common \
    python3 \
    python3-pip \
    cmake \
    build-essential \
    gcc \
    g++ \
    automake \
    libboost-all-dev \
    unzip \
    ninja-build \
    && rm -rf /var/lib/apt/lists/*

# Install Mono (required for C# components)
RUN apt-get update && apt-get install -y gnupg ca-certificates \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
    && echo "deb https://download.mono-project.com/repo/ubuntu stable-focal main" | tee /etc/apt/sources.list.d/mono-official-stable.list \
    && apt-get update \
    && apt-get install -y mono-complete mono-devel nuget \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip3 install --no-cache-dir psutil Sphinx

# Set up build directory
WORKDIR /build

# Build LLVM 6.0 with Clang
ENV LLVM_VERSION=release/6.x
RUN git clone --depth 1 --branch ${LLVM_VERSION} https://github.com/llvm/llvm-project.git \
    && cd llvm-project \
    && mkdir build \
    && cd build \
    && cmake -G Ninja \
             -DCMAKE_BUILD_TYPE=Release \
             -DLLVM_ENABLE_PROJECTS="clang" \
             -DLLVM_ENABLE_ASSERTIONS=ON \
             -DCMAKE_INSTALL_PREFIX=/usr/local \
             ../llvm \
    && ninja \
    && ninja install

# # Build libclc
# RUN cd /build \
#     && git clone https://github.com/llvm-mirror/libclc.git \
#     && cd libclc \
#     && ./configure.py --with-llvm-config=/usr/local/bin/llvm-config \
#                       --prefix=/usr/local/libclc \
#     && make -j$(nproc) \
#     && make install

# Build Bugle
RUN cd /build \
    && git clone https://github.com/mc-imperial/bugle.git \
    && cd bugle \
    && mkdir build \
    && cd build \
    && cmake -DCMAKE_BUILD_TYPE=Release \
             -DLLVM_CONFIG_EXECUTABLE=/usr/local/bin/llvm-config \
             .. \
    && make -j$(nproc)

# Build Z3 SMT Solver
# ENV Z3_RELEASE=z3-4.6.0
# RUN cd /build \
#     && git clone https://github.com/Z3Prover/z3.git \
#     && cd z3 \
#     && git checkout -b ${Z3_RELEASE} ${Z3_RELEASE} \
#     && python3 scripts/mk_make.py \
#     && cd build \
#     && make -j$(nproc) \
#     && make install \
#     && ln -s /usr/local/bin/z3 /usr/local/bin/z3.exe

# # Build CVC4 SMT Solver (Optional but recommended)
# ENV CVC4_RELEASE=1.5
# RUN cd /build \
#     && git clone https://github.com/CVC4/CVC4.git \
#     && cd CVC4 \
#     && git checkout -b ${CVC4_RELEASE} ${CVC4_RELEASE} \
#     && MACHINE_TYPE="x86_64" contrib/get-antlr-3.4 \
#     && ./autogen.sh \
#     && export ANTLR=/build/CVC4/antlr-3.4/bin/antlr3 \
#     && ./configure --with-antlr-dir=/build/CVC4/antlr-3.4 \
#                    --prefix=/usr/local \
#                    --best --enable-gpl \
#                    --without-glpk --without-abc \
#                    --disable-shared --enable-static \
#     && make -j$(nproc) \
#     && make install \
#     && ln -s /usr/local/bin/cvc4 /usr/local/bin/cvc4.exe

# Clone and build GPUVerify
RUN cd /build \
    && git clone https://github.com/mc-imperial/gpuverify.git \
    && cd gpuverify \
    && nuget restore GPUVerify.sln \
    && msbuild /m \
               /p:Configuration=Release \
               /p:CodeAnalysisRuleSet=$PWD/StyleCop.ruleset \
               GPUVerify.sln

RUN apt-get update && apt-get install -y z3
RUN ln -s /usr/bin/z3 /usr/local/bin/z3.exe

# Configure GPUVerify with gvfindtools.py
RUN cd /build/gpuverify \
    && cp gvfindtools.templates/gvfindtools.dev.py gvfindtools.py \
    && sed -i "s|rootDir = .*|rootDir = '/build'|g" gvfindtools.py \
    && sed -i "s|bugleSrcDir = .*|bugleSrcDir = '/build/bugle'|g" gvfindtools.py \
    && sed -i "s|bugleBinDir = .*|bugleBinDir = '/build/bugle/build'|g" gvfindtools.py \
    && sed -i "s|libclcSrcDir = .*|libclcSrcDir = '/build/libclc'|g" gvfindtools.py \
    && sed -i "s|libclcInstallDir = .*|libclcInstallDir = '/usr/local/libclc'|g" gvfindtools.py \
    && sed -i "s|llvmSrcDir = .*|llvmSrcDir = '/build/llvm-project/llvm'|g" gvfindtools.py \
    && sed -i "s|llvmBinDir = .*|llvmBinDir = '/usr/local/bin'|g" gvfindtools.py \
    && sed -i "s|llvmLibDir = .*|llvmLibDir = '/usr/local/lib'|g" gvfindtools.py \
    && sed -i "s|gpuVerifyBinDir = .*|gpuVerifyBinDir = '/build/gpuverify/Binaries'|g" gvfindtools.py \
    && sed -i "s|z3SrcDir = .*|z3SrcDir = '/build/z3'|g" gvfindtools.py \
    && sed -i "s|z3BinDir = .*|z3BinDir = '/usr/local/bin'|g" gvfindtools.py \
    && sed -i "s|cvc4SrcDir = .*|cvc4SrcDir = '/build/CVC4'|g" gvfindtools.py \
    && sed -i "s|cvc4BinDir = .*|cvc4BinDir = '/usr/local/bin'|g" gvfindtools.py

RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb && \
    dpkg -i cuda-keyring_1.1-1_all.deb && \
    rm cuda-keyring_1.1-1_all.deb && \
    apt-get update && \
    apt-get install -y \
    cuda-cudart-dev-12-3 \
    cuda-nvcc-12-3 \
    libcurand-dev-12-3 \
    gcc-multilib \
    g++-multilib \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Add GPUVerify to PATH
ENV PATH="/build/gpuverify:${PATH}"

# Set working directory for user
WORKDIR /work

# Create symlink for easier access
# RUN ln -s /build/gpuverify/GPUVerify.py /usr/local/bin/gpuverify

# Verify installation (optional test suite - can be commented out to save build time)
# RUN cd /build/gpuverify \
#     && python3 ./gvtester.py --write-pickle run.pickle testsuite/

# Entry point
CMD ["/bin/bash"]
