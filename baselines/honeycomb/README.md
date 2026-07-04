hipcc --offload-arch=gfx1030 -O2 -c -fgpu-rdc -Idep_hip/torch_include -Idep_hip/torch_include/torch/csrc/api/include -std=c++17 gemm_kernels.hip.cpp -o gemm_kernels.out

docker run -v .:/workspace -it --rm rocm/pytorch:rocm5.7_ubuntu22.04_py3.10_pytorch_2.0.1
docker run -u $(id -u):$(id -g) -v .:/workspace -it --rm rocm/pytorch:rocm5.7_ubuntu22.04_py3.10_pytorch_2.0.1

/opt/conda/envs/py_3.10/lib/python3.10/site-packages/torch/include

hipcc --offload-arch=gfx1030 -c -fgpu-rdc -I/opt/conda/envs/py_3.10/lib/python3.10/site-packages/torch/include -I/opt/conda/envs/py_3.10/lib/python3.10/site-packages/torch/include/torch/csrc/api/include -std=c++17 gemm_kernels.hip.cpp -o gemm_kernels.out



docker run -u $(id -u):$(id -g) -v .:/workspace -it --rm rocm/vllm:rocm7.0.0_vllm_0.11.1_20251103

/usr/local/lib/python3.12/dist-packages/torch/include


hipcc --offload-arch=gfx1030 -c -fgpu-rdc -I/usr/local/lib/python3.12/dist-packages/torch/include -I/usr/local/lib/python3.12/dist-packages/torch/include/torch/csrc/api/include -I/workspace/vllm/csrc -I/workspace/vllm/csrc/quantization/awq -std=c++17 gemm_kernels.hip.cpp -o gemm_kernels.out

hipify-clang \
-I/usr/local/lib/python3.12/dist-packages/torch/include \
-I/usr/local/lib/python3.12/dist-packages/torch/include/torch/csrc/api/include \
-I/usr/local/cuda/include \
-I/workspace/vllm/csrc \
-I/usr/local/cuda/include/thrust \
--cuda-path=/usr/local/cuda \
-o gemm_kernels.hip.cpp /workspace/vllm/csrc/quantization/awq/gemm_kernels.cu -- -std=c++17 \
-D__HIPCC__ \
-D__HIP_PLATFORM_AMD__ \
-include /usr/include/c++/11/climits \
-include /usr/include/c++/11/limits.h


hipify-perl /workspace/vllm/csrc/quantization/awq/gemm_kernels.cu > gemm_kernels.hip.cpp
hipcc --offload-arch=gfx1030 -O2 -c -fgpu-rdc \
  -I/workspace/fake_cuda \
  -I/usr/local/lib/python3.12/dist-packages/torch/include \
  -I/usr/local/lib/python3.12/dist-packages/torch/include/torch/csrc/api/include \
  -I/workspace/vllm/csrc \
  -I/workspace/vllm/csrc -I/workspace/vllm/csrc/quantization/awq \
  -std=c++17 \
  -D__HIP_PLATFORM_AMD__ \
  -D__HIPCC__ \
  gemm_kernels.hip.cpp \
  -o gemm_kernels.out


wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/3bf863cc.pub
sudo apt-key add 3bf863cc.pub
echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/ /" \
  | sudo tee /etc/apt/sources.list.d/cuda.list
sudo apt update
sudo apt install -y cuda-compiler-12-4

./honeycamb/dev/run-builder.sh bugstudy-gklee/src bugstudy-hc
