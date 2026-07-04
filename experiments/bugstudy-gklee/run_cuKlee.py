import os
import subprocess
from pathlib import Path
import sys


CUDA_PATH = "/usr/local/cuda"  # Path to CUDA installation
# INPUT_DIR = "/home/mvh6224/vllm/csrc"  # Path to source directory
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


def compile_cu_file(cu_file, depPath=None):
    print(f"Compiling {cu_file}...")
    # for dirpath in Path(INPUT_DIR).rglob('*'):
    #     if dirpath.is_dir():
    #         include_dirs.append(str(dirpath))

    clang_command = [
        "clang++-13",
        "-g",
        "-O0",
        # "-disable-O0-optnone",
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
        # "-I", depPath,
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
        # "-emit-llvm",
        # "-c",
        # cu_file
    ]
    
    clang_command.extend(["-emit-llvm",
        "-c",
        cu_file])
    
    return run_command(clang_command)

def link_combine(dir):
    for file in os.listdir(dir):
        if file.endswith("cuda-nvptx64-nvidia-cuda-sm_80.bc") or file.endswith("combined.bc"):
            continue
        if not file.endswith(".bc"):
            continue
        
        output_prefix = dir+"/"+file[:file.find(".bc")]
        host_bc_file = f"{output_prefix}.bc"
        cuda_bc_file = f"{output_prefix}-cuda-nvptx64-nvidia-cuda-sm_80.bc"
        combined_bc_file = f"{output_prefix}{COMBINED_SUFFIX}"

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
            print(f"Error: Missing {host_bc_file} or {cuda_bc_file} file. Skipping combination.")

def compileDir(outputDir, inputDir):
    # Create output directory
    os.makedirs(outputDir, exist_ok=True)
    original_dir = os.getcwd()
    os.chdir(outputDir)

    # Step 1: Compile all .cu files
    print("Compiling CUDA files...")
    cu_files = list(Path(inputDir).rglob("*.cu"))
    if not cu_files:
        print("No .cu files found in the source directory.")
        sys.exit(1)
    
    failed_files = []

    for cu_file in cu_files:
        filename = cu_file.stem
        output_prefix = filename

        host_bc_file = f"{output_prefix}.bc"
        cuda_bc_file = f"{output_prefix}-cuda-nvptx64-nvidia-cuda-sm_80.bc"
        combined_bc_file = f"{output_prefix}{COMBINED_SUFFIX}"

        # if not os.path.exists(host_bc_file):
        #     if not compile_cu_file(str(cu_file)):
        #         failed_files.append(str(cu_file))
        #         continue
        if output_prefix=="vllm9391":
            continue
        
        compile_cu_file(str(cu_file))
        # if os.path.exists(combined_bc_file):
        #     continue

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

    # print(f"All files compiled and combined. Output directory: {OUTPUT_DIR}")
    if failed_files:
        print(failed_files)
    print("# of .cu:", len(cu_files), "# of failed:", len(failed_files))


import subprocess
import logging

TIMEOUT_LIMIT = 6*60*60

def run_klee_on_bc_file(bc_file, logDir, outputdir):
    one_timeout = 3600
    try:
        os.makedirs(logDir, exist_ok=True)

        log_file = os.path.join(logDir, os.path.splitext(os.path.basename(bc_file))[0] + '_klee_output.log')
        if os.path.exists(log_file):
            return True         

        outputdir = os.path.join(outputdir, os.path.splitext(os.path.basename(bc_file))[0])
        os.makedirs(outputdir, exist_ok=True)
        
        # Run KLEE and capture its output and error in the log file
        with open(log_file, 'w') as output_file:
            subprocess.run(['CUDAAnalyzer', f"--timeout={one_timeout}", f"--output-dir={outputdir}", bc_file], stdout=output_file, stderr=output_file, check=True)
            # subprocess.run(['CUDAAnalyzer', f"--timeout={one_timeout}", f"--output-dir={outputdir}", "--sym-loop=false", bc_file], stdout=output_file, stderr=output_file, check=True)
        
        with open(log_file, 'r') as output_file:
            log_content = output_file.read()
            # if 'Aborted (core dumped)' in log_content:
            #     print(f"KLEE aborted on {bc_file}. See log for details.")
            #     logging.error(f"KLEE aborted (core dumped) on {bc_file}.")
            #     return False
            if "KLEE: done: completed paths =" not in log_content:
                print(f"KLEE not complete on {bc_file}. See log for details.")
                logging.error(f"KLEE not complete on {bc_file}.")
                return False
            else:
                print(f"Successfully ran KLEE on {bc_file}. Output saved to {log_file}")
                return True
    
    except subprocess.TimeoutExpired:
        # Handle the timeout error
        logging.error(f"KLEE run on {bc_file} timed out after {TIMEOUT_LIMIT} seconds.")
        print(f"KLEE run on {bc_file} timed out after {TIMEOUT_LIMIT} seconds. See log for details.")
        return False

    except subprocess.CalledProcessError as e:
        # Log the error if KLEE throws an exception
        logging.error(f"Error running KLEE on {bc_file}: {str(e)}")
        print(f"Error running KLEE on {bc_file}. See log for details.")
        return False

if __name__ == "__main__":
    # compileDir("/home/mvh6224/CUDA-BOSolver/bugstudy-gklee/src2", "/home/mvh6224/CUDA-BOSolver/bugstudy-gklee/src2")

    directory_path = "/home/mvh6224/CUDA-BOSolver/bugstudy-gklee/src2" 
    log_directory = "/home/mvh6224/CUDA-BOSolver/bugstudy-gklee/log2"
    output_directory = "/home/mvh6224/CUDA-BOSolver/bugstudy-gklee/result2"
    os.makedirs(output_directory, exist_ok=True)
    failed_files = []
    for dname in os.listdir(directory_path):
        if not dname.endswith('.json'):
            continue
        # if not dname.endswith('_combined.bc'):
        #     continue
        # if dname not in ["vllm1514-2_combined.bc", "vllm26192_combined.bc", "vllm9425_combined.bc", "vllm1841_combined.bc", "vllm2164_combined.bc",
        #                  "vllm9391_combined.bc", "vllm9391-2_combined.bc", "vllm9391-3_combined.bc", "vllm9391-4_combined.bc"]: 
        #     continue
        bc_file = os.path.join(directory_path, dname)
        tmp = run_klee_on_bc_file(bc_file, log_directory, output_directory)
        if not tmp:
            failed_files.append(dname)
    print("failed files:", failed_files)
