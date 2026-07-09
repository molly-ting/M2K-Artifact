import os
import subprocess
from pathlib import Path
import sys


CUDA_PATH = "/usr/local/cuda"  # Path to CUDA installation
COMBINED_SUFFIX = "_combined.bc"  # Suffix for the combined .bc files
project_path = Path(__file__).parent.parent
signed_clang_path = os.getenv("SIGNED_CLANG_PATH", "clang++-13")

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

OPENMP_INCLUDE_DIRS = [
    Path("/usr/lib/gcc/x86_64-linux-gnu/11/include"),
    Path("/usr/lib/gcc/x86_64-linux-gnu/12/include"),
    Path("/usr/lib/gcc/x86_64-linux-gnu/13/include"),
]

def _resolve_first_existing_path(paths):
    for path in paths:
        if path.exists():
            return path
    return None

OPENMP_INCLUDE_DIR = _resolve_first_existing_path(OPENMP_INCLUDE_DIRS)


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
        signed_clang_path,
        "-g",
        "-x", "cuda", 
        "--cuda-gpu-arch=sm_80",  
        "-std=c++17",
        "-Xclang",
        "-fcuda-allow-variadic-functions",
        "-D__CUDA_ARCH__=800",
        "-I", f"{CUDA_PATH}/include",
        "-I", TORCH_INCLUDE,
        "-I", TORCH_INCLUDE + "/torch/csrc/api/include",
        *(["-I", str(OPENMP_INCLUDE_DIR)] if OPENMP_INCLUDE_DIR is not None else []),
        "-I", root_path,
        "-I", "/usr/include/python3.10",
        "-I", f"{project_path}/compile/include/cutlass/include",
        "-I", f"{project_path}/compile/include",
        "-I", f"{project_path}/compile/include/cutlass/examples",
    ]

    if "cutlass" in cu_file:
        clang_command.append("-DENABLE_SCALED_MM_SM90=1")
        clang_command.append("-DENABLE_SCALED_MM_SM100=1")
    
    clang_command.extend(["-emit-llvm",
        "-c",
        cu_file])
    
    if "rocm" in cu_file:
        return False  # Skip compilation for ROCm files
    
    return run_command(clang_command)

def compile_coverage():
    original_dir = os.getcwd()
    root_dir = os.path.join(project_path, "experiments", "coverage")
    for dname in os.listdir(root_dir):
        dir_path = os.path.join(root_dir, dname)
        cu_dir = dir_path
        if dname == "5169":
            cu_dir = os.path.join(dir_path, "punica")
        if dname == "6649":
            cu_dir = os.path.join(dir_path, "quantization", "fp8")
        if dname == "9391":
            cu_dir = os.path.join(dir_path, "quantization", "compressed_tensors")
        if dname == "9425":
            cu_dir = os.path.join(dir_path, "quantization", "fp8")
        if dname == "12413":
            cu_dir = os.path.join(dir_path, "moe")

        os.chdir(dir_path)
        for file in os.listdir(cu_dir):
            if file.endswith(".cu"):
                output_prefix = dir_path+"/"+file[:file.find(".cu")]
                host_bc_file = f"{output_prefix}.bc"
                cuda_bc_file = f"{output_prefix}-cuda-nvptx64-nvidia-cuda-sm_80.bc"
                combined_bc_file = f"{output_prefix}{COMBINED_SUFFIX}"
                if not os.path.exists(cuda_bc_file) or not os.path.exists(host_bc_file):
                    success = compile_cu_file(os.path.join(cu_dir, file), depPath=cu_dir)
                    if not success:
                        print(f"Failed to compile {file} in {dir_path}")
                        continue

                if os.path.exists(combined_bc_file):
                    continue

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

    os.chdir(original_dir)


import subprocess
import logging

TIMEOUT_LIMIT = 6*60*60

def run_klee_on_json_file(json_file, logDir, outputdir, useDirName=False):
    one_timeout = 3600
    try:
        # Ensure output directory exists
        os.makedirs(logDir, exist_ok=True)
        
        # Create a log file for this specific KLEE run (output and error)
        if useDirName:
            dir_name = os.path.basename(os.path.dirname(json_file))
            log_file = os.path.join(logDir, dir_name + '_klee_output.log')
            outputdir = os.path.join(outputdir, dir_name)
            os.makedirs(outputdir, exist_ok=True)
        else:
            log_file = os.path.join(logDir, os.path.splitext(os.path.basename(json_file))[0] + '_klee_output.log')
        if os.path.exists(log_file):
            return True         
        
        # Run KLEE and capture its output and error in the log file
        with open(log_file, 'w') as output_file:
            subprocess.run(['cuKLEE', f"--timeout={one_timeout}", f"--output-dir={outputdir}", json_file], stdout=output_file, stderr=output_file, timeout=TIMEOUT_LIMIT, check=True)
        
        with open(log_file, 'r') as output_file:
            log_content = output_file.read()
            # if 'Aborted (core dumped)' in log_content:
            #     print(f"cuKLEE aborted on {bc_file}. See log for details.")
            #     logging.error(f"cuKLEE aborted (core dumped) on {bc_file}.")
            #     return False
            if "KLEE: done: completed paths =" not in log_content:
                print(f"cuKLEE not complete on {json_file}. See log for details.")
                logging.error(f"cuKLEE not complete on {json_file}.")
                return False
            else:
                print(f"Successfully ran cuKLEE on {json_file}. Output saved to {log_file}")
                return True
    
    except subprocess.TimeoutExpired:
        # Handle the timeout error
        logging.error(f"cuKLEE run on {json_file} timed out after {TIMEOUT_LIMIT} seconds.")
        print(f"cuKLEE run on {json_file} timed out after {TIMEOUT_LIMIT} seconds. See log for details.")
        return False

    except subprocess.CalledProcessError as e:
        # Log the error if KLEE throws an exception
        logging.error(f"Error running cuKLEE on {json_file}: {str(e)}")
        print(f"Error running cuKLEE on {json_file}. See log for details.")
        return False

root_path = Path(__file__).parent

def run_original():
    input_dir = os.path.join(root_path, "coverage")
    logDir = os.path.join(root_path, "coverage-cuKLEE-log")
    outputdir = os.path.join(root_path, "coverage-cuKLEE-result")

    for dname in os.listdir(input_dir):
        if dname == "simplified":
            continue
        dir_path = os.path.join(input_dir, dname)
        for file in os.listdir(dir_path):
            if file.endswith(".json"):
                json_file = os.path.join(dir_path, file)
                run_klee_on_json_file(json_file, logDir, outputdir, useDirName=True)

def run_simplified():
    input_dir = os.path.join(root_path, "coverage", "simplified")
    logDir = os.path.join(root_path, "coverage-cuKLEE-log", "simplified")
    outputdir = os.path.join(root_path, "coverage-cuKLEE-result", "simplified")

    for file in os.listdir(input_dir):
        if file.endswith(".json"):
            json_file = os.path.join(input_dir, file)
            run_klee_on_json_file(json_file, logDir, outputdir)

if __name__ == "__main__":
    compile_coverage()
    run_original()
    run_simplified()
