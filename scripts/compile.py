import os
import subprocess
from pathlib import Path
import sys


CUDA_PATH = "/usr/local/cuda"  # Path to CUDA installation
COMBINED_SUFFIX = "_combined.bc"  # Suffix for the combined .bc files

# Manually define PyTorch include paths
try:
    import torch
    TORCH_INCLUDE = os.path.join(os.path.dirname(torch.__file__), "include")
    print(TORCH_INCLUDE)
    if not os.path.exists(TORCH_INCLUDE):
        raise FileNotFoundError(f"PyTorch include directory not found at {TORCH_INCLUDE}")
except ImportError:
    print("PyTorch is not installed. Please install it and try again.")
    sys.exit(1)


# Utility function to run shell commands
def run_command(command, cwd=None):
    print(f"Running command: {' '.join(command)}")
    result = subprocess.run(command, cwd=cwd, text=True, capture_output=True)
    if result.returncode != 0:
        print(f"Error: Command failed with return code {result.returncode}")
        print(f"Stdout: {result.stdout}")
        print(f"Stderr: {result.stderr}")
        return False
    else:
        print(result.stdout)
        return True


def compile_cu_file(cu_file, root_path):
    print(f"Compiling {cu_file}...")

    clang_command = [
        "clang++-13",
        "-g",
        "-x", "cuda", 
        "--cuda-gpu-arch=sm_80",  
        "-std=c++17",
        # "-DENABLE_BF16",
        "-Xclang",
        "-fcuda-allow-variadic-functions",
        "-D__CUDA_ARCH__=800",
        "-I", f"{CUDA_PATH}/include",
        "-I", TORCH_INCLUDE,
        "-I", TORCH_INCLUDE + "/torch/csrc/api/include",
        # "-I", "/home/mvh6224/pybind11/include",
        "-I", root_path,
        "-I", "/usr/include/python3.10",
        "-I", "/opt/rocm/include",
        "-I", "/home/mvh6224/cutlass/include",
        "-I", "/home/mvh6224/CUDA-BOSolver/scripts/include",
        "-I", "/home/mvh6224/CUDA-BOSolver/scripts/include/cutlass/examples",
        # "-I", "/home/mvh6224/flashinfer/include",
        # "-I", "/home/mvh6224/CUDA-BOSolver/scripts/papers/lutGEMM/include",
        # "-I", "/home/mvh6224/raft/cpp/include",
        # "-I", "/usr/lib/llvm-13/lib/clang/13.0.1/include",
        # "-I", "/usr/local/cuda/include/crt/",
        # "-I", "/home/mvh6224/CUDA-BOSolver/scripts/papers/QuaRot/kernels/include",
        "-emit-llvm",
        "-c",
        cu_file
    ]
    
    if "rocm" in cu_file:
        return False  # Skip compilation for ROCm files
    
    return run_command(clang_command)


def compileDir(outputDir, inputDir, filter_test=True, contain_dirname=True):
    os.makedirs(outputDir, exist_ok=True)
    original_dir = os.getcwd()
    os.chdir(outputDir)

    print("Compiling CUDA files...")
    cu_files = list(Path(inputDir).rglob("*.cu"))
    if not cu_files:
        print("No .cu files found in the source directory.")
        sys.exit(1)
    
    failed_files = []

    for cu_file in cu_files:
        filename = cu_file.stem

        if filter_test and filename.endswith("_test"):
            continue

        if contain_dirname:
            parent_dir = cu_file.parent.name
            output_prefix = filename if parent_dir == "csrc" else parent_dir + "_" + filename 
        else:
            output_prefix = filename

        host_bc_file = f"{output_prefix}.bc"
        cuda_bc_file = f"{output_prefix}-cuda-nvptx64-nvidia-cuda-sm_80.bc"
        combined_bc_file = f"{output_prefix}{COMBINED_SUFFIX}"

        if not os.path.exists(host_bc_file):
            if not compile_cu_file(str(cu_file)):
                failed_files.append(str(cu_file))
                continue

        if os.path.exists(combined_bc_file):
            continue

        if os.path.exists(host_bc_file) and os.path.exists(cuda_bc_file):
            print(f"Combining {host_bc_file} and {cuda_bc_file} into {combined_bc_file}...")
            run_command([
                "llvm-link-13",
                "-o", combined_bc_file,
                host_bc_file,
                cuda_bc_file
            ])
            run_command([
                "llvm-dis-13",
                combined_bc_file
            ])
        else:
            print(f"Error: Missing .bc or -cuda.bc file for {cu_file}. Skipping combination.")

    os.chdir(original_dir)
    if failed_files:
        print(failed_files)
    print("# of .cu:", len(cu_files), "# of failed:", len(failed_files))


if __name__ == "__main__":
    compileDir("", "")