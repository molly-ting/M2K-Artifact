FROM rocm/dev-ubuntu-22.04:5.7



# Install utilities and HIPify tools
RUN apt-get update && apt-get install -y \
    hipify-clang \
    build-essential \
    clang \
    cmake \
    git \
    vim \
    wget 
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb && \
    dpkg -i cuda-keyring_1.1-1_all.deb && \
    rm cuda-keyring_1.1-1_all.deb && \
    apt-get update && \
    apt-get install -y \
    cuda-cudart-dev-12-3 \
    cuda-nvcc-12-3 \
    libcurand-dev-12-3 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set CUDA environment variables
ENV CUDA_HOME=/usr/local/cuda
ENV PATH=${CUDA_HOME}/bin:${PATH}
ENV LD_LIBRARY_PATH=${CUDA_HOME}/lib64:${LD_LIBRARY_PATH}


COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
COPY hipify_directory.py /usr/local/bin/hipify_directory.py
RUN chmod +x /usr/local/bin/hipify_directory.py

WORKDIR /workspace


# ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
