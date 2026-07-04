FROM rust:1.83

# Set working directory
WORKDIR /workspace

# Clone the honeycomb repository
RUN git clone https://github.com/Jiacheng/honeycomb-osdi23-ae.git

# Set working directory to hypervisor
WORKDIR /workspace/honeycomb-osdi23-ae/hypervisor

# Build the hypervisor
RUN cargo build --release

ENV PATH="/workspace/honeycomb-osdi23-ae/hypervisor/target/release:${PATH}"

WORKDIR /output

# Set entrypoint to bash for interactive use
CMD ["/bin/bash"]