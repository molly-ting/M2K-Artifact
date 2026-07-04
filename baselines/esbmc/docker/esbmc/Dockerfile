FROM ubuntu:22.04

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies and add ESBMC PPA
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:esbmc/esbmc && \
    apt-get update && \
    apt-get install -y esbmc && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Reset to default
ENV DEBIAN_FRONTEND=

# Set working directory
WORKDIR /workspace

CMD ["/bin/bash"]