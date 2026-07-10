#!/usr/bin/env bash
# compile CUDA files to LLVM bitcode in the input directory and store the output in the output directory
# usage: python3 cuKLEE/compile_cuda.py --input-dir=<input_directory> --output-dir=<output_directory>
python3 ../cuKLEE/compile_cuda.py --input-dir=./cuda_files --output-dir=.
# dynamic_scaled_fp8_quant.json stores the LLVM bitcode file path (the absolute path or relative path to the project directory) and constraints for arguments of the cuda function.
# usage: cuKLEE --timeout=<seconds> --output-dir=<dir to store the z3 constraints> <json_file>
cuKLEE --timeout=3600 --output-dir=. dynamic_scaled_fp8_quant.json
