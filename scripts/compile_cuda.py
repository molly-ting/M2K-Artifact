import argparse
import os
import subprocess
from pathlib import Path
import sys


CUDA_PATH = "/usr/local/cuda"  # Path to CUDA installation
COMBINED_SUFFIX = "_combined.bc"  # Suffix for the combined .bc files
project_path = Path(__file__).parent.parent

def _resolve_signed_clang_path():
    signed_clang_path = os.getenv("SIGNED_CLANG_PATH")
    if not signed_clang_path:
        return "clang++-13"

    path = Path(signed_clang_path)
    if path.is_dir():
        return str(path / "clang++")
    return signed_clang_path

signed_clang_path = _resolve_signed_clang_path()

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

def compile_vllm():
    outputDir = os.path.join(project_path, "compile", "vllm_0_9_0")
    inputDir = os.path.join(project_path, "benchmark", "vllm_0_9_0", "csrc")
    compileDir(outputDir, inputDir, filter_test=True, contain_dirname=True)
    original_dir = os.getcwd()
    os.chdir(outputDir)
    run_command([
        "llvm-link-13",
        "-o", "cutlass_w8a8_scaled_mm_entry_combined.bc",
        "cutlass_w8a8_scaled_mm_entry_combined.bc",
        "moe_moe_data_combined.bc"
    ])
    run_command([
        "llvm-dis-13",
        "cutlass_w8a8_scaled_mm_entry_combined.bc"
    ])
    os.chdir(original_dir)

def compile_paper():
    original_dir = os.getcwd()
    targetDir = os.path.join(project_path, "benchmark", "paper")
    for dname in os.listdir(targetDir):
        dir_path = os.path.join(targetDir, dname)
        has_cpp_file = False
        cpp_bc_files = []
        combined_bc_files = []
        for file in os.listdir(dir_path):
            if file.endswith(".cu"):
                os.chdir(dir_path)

                output_prefix = dir_path+"/"+file[:file.find(".cu")]
                host_bc_file = f"{output_prefix}.bc"
                cuda_bc_file = f"{output_prefix}-cuda-nvptx64-nvidia-cuda-sm_80.bc"
                combined_bc_file = f"{output_prefix}{COMBINED_SUFFIX}"
                combined_bc_files.append(combined_bc_file)
                if not os.path.exists(cuda_bc_file) or not os.path.exists(host_bc_file):
                    success = compile_cu_file(os.path.join(dir_path, file), root_path=dir_path)
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

            if file.endswith(".cpp"):
                has_cpp_file = True
                output_prefix = dir_path+"/"+file[:file.find(".cpp")]
                cpp_bc_file = f"{output_prefix}_cpp.bc"
                cpp_bc_files.append(cpp_bc_file)
                if os.path.exists(cpp_bc_file):
                    continue

                run_command([
                    signed_clang_path,
                    "-g",
                    "-emit-llvm",
                    "-c",
                    os.path.join(dir_path, file),
                    "-o",
                    cpp_bc_file,
                    "-std=c++17",
                    "-I", TORCH_INCLUDE,
                    "-I", TORCH_INCLUDE + "/torch/csrc/api/include",
                    "-I", f"{CUDA_PATH}/include",
                    *(["-I", str(OPENMP_INCLUDE_DIR)] if OPENMP_INCLUDE_DIR is not None else []),
                    "-I", dir_path,
                    "-I", "/usr/include/python3.10"
                ])

        if has_cpp_file:
            target_files = []
            for combined_bc_file in combined_bc_files:
                if not os.path.exists(combined_bc_file):
                    continue
                target_files.append(combined_bc_file)

            merged_combined_bc_file = None
            for cpp_bc_file in cpp_bc_files:
                if not os.path.exists(cpp_bc_file):
                    continue
                target_files.append(cpp_bc_file)
                merged_combined_bc_file = cpp_bc_file[:-7] + COMBINED_SUFFIX

            run_command([
                "llvm-link-13",
                "-o", merged_combined_bc_file] + target_files)
            
            run_command([
                "llvm-dis-13",
                merged_combined_bc_file
            ])
    os.chdir(original_dir)

def _sanitize_cuda_source(cu_file, out_dir):
    source_path = Path(cu_file)
    source_text = source_path.read_text()
    if "vec.type()" not in source_text:
        return source_path

    sanitized_root = Path(out_dir) / ".sanitized_sources"
    sanitized_root.mkdir(parents=True, exist_ok=True)
    sanitized_path = sanitized_root / source_path.name
    sanitized_text = source_text.replace("vec.type()", "vec.scalar_type()")
    sanitized_path.write_text(sanitized_text)
    return sanitized_path

def compile_hf():
    original_dir = os.getcwd()
    targetDir = os.path.join(project_path, "benchmark", "huggingface")
    outputDir = os.path.join(project_path, "compile", "huggingface")
    os.makedirs(outputDir, exist_ok=True)

    for dname in os.listdir(targetDir):
        dir_path = os.path.join(targetDir, dname)
        out_model_dir = os.path.join(outputDir, dname)
        os.makedirs(out_model_dir, exist_ok=True)
        os.chdir(out_model_dir)

        for file in os.listdir(dir_path):
            if file.endswith(".cu"):
                output_prefix = out_model_dir+"/"+file[:file.find(".cu")]
                host_bc_file = f"{output_prefix}.bc"
                cuda_bc_file = f"{output_prefix}-cuda-nvptx64-nvidia-cuda-sm_80.bc"
                combined_bc_file = f"{output_prefix}{COMBINED_SUFFIX}"
                if not os.path.exists(cuda_bc_file) or not os.path.exists(host_bc_file):
                    sanitized_file = _sanitize_cuda_source(os.path.join(dir_path, file), out_model_dir)
                    success = compile_cu_file(str(sanitized_file), root_path=dir_path)
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

            if "mgalkin" in dname and file.endswith(".cpp"):
                output_prefix = out_model_dir+"/"+file[:file.find(".cpp")]
                cpp_bc_file = f"{output_prefix}_cpp.bc"
                if os.path.exists(cpp_bc_file):
                    continue

                run_command([
                    signed_clang_path,
                    "-g",
                    "-emit-llvm",
                    "-c",
                    os.path.join(dir_path, file),
                    "-o",
                    cpp_bc_file,
                    "-std=c++17",
                    "-I", TORCH_INCLUDE,
                    "-I", TORCH_INCLUDE + "/torch/csrc/api/include",
                    "-I", dir_path,
                    "-I", "/usr/include/python3.10",
                    "-I", f"{CUDA_PATH}/include"
                ])
        
        if "mgalkin" in dname:
            target_files = []
            for file in os.listdir(out_model_dir):
                if file.endswith(COMBINED_SUFFIX) or file.endswith("_cpp.bc"):
                    target_files.append(os.path.join(out_model_dir, file))

            if target_files:
                combined_bc_file = os.path.join(out_model_dir, f"rspmm{COMBINED_SUFFIX}")
                run_command([
                    "llvm-link-13",
                    "-o", combined_bc_file] + target_files)
                
                run_command([
                    "llvm-dis-13",
                    combined_bc_file
                ])
    os.chdir(original_dir)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="compile cuda files."
    )

    parser.add_argument(
        "--input-dir", type=str, required=False, help="Input directory containing .cu files"
    )
    parser.add_argument(
        "--out-dir", type=str, required=False, help="Output directory for compiled files"
    )

    parser.add_argument(
        "--input-file", type=str, required=False, help="Input .cu file to compile"
    )
    parser.add_argument(
        "--compile-paper", type=bool, required=False, help="Compile cuda files in research papers"
    )
    parser.add_argument(
        "--compile-vllm", type=bool, required=False, help="Compile cuda files in vLLM"
    )
    parser.add_argument(
        "--compile-hf", type=bool, required=False, help="Compile cuda files in Hugging Face models"
    )

    args = parser.parse_args()
    if args.compile_vllm:
        compile_vllm()
    elif args.compile_paper:
        compile_paper()
    elif args.compile_hf:
        compile_hf()
    elif args.input_dir and args.out_dir:
        compileDir(args.out_dir, args.input_dir)
    elif args.input_file and args.out_dir:
        os.chdir(args.out_dir)
        compile_cu_file(args.input_file, root_path=os.path.dirname(args.input_file))
