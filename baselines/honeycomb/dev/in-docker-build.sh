#!/bin/bash
# filepath: /home/sxia/CUDA-BOSolver/bugstudy-hc/hipify-all.sh

set -e

if [ -z "$1" ]; then
    echo "Usage: $0 <directory>"
    echo "Example: $0 /workspace/bugstudy-hc"
    exit 1
fi

SRC_DIR="$1"

if [ ! -d "$SRC_DIR" ]; then
    echo "Error: Directory '$SRC_DIR' does not exist"
    exit 1
fi

echo "Processing .cu files in: $SRC_DIR"
echo "========================================"

# Find all .cu files and process them
find "$SRC_DIR" -name "*.cu" -type f | while read -r cu_file; do
    # Get basename without extension
    basename_no_ext=$(basename "$cu_file" .cu)
    dir=$(dirname "$cu_file")
    
    hip_file="${cu_file}.hip"
    out_file="${dir}/${basename_no_ext}.out"
    
    echo ""
    echo "Processing: $cu_file"
    echo "  -> Hipifying to: $hip_file"
    
    if [ -f "$hip_file" ]; then
        echo "  ⚠️  Output file $hip_file already exists. Skipping."
        continue
    else
        # Step 1: Hipify
        if hipify-perl "$cu_file" > "$hip_file"; then
            echo "  ✓ Hipify succeeded"
        else
            echo "  ✗ Hipify failed for $cu_file"
            continue
        fi
    fi

    if [ -f "$out_file" ]; then
        echo "  ⚠️  Output file $out_file already exists. Skipping compilation."
        continue
    fi
    

    
    # Step 2: Compile with hipcc
    echo "  -> Compiling to: $out_file"
    if hipcc --offload-arch=gfx1030 -O2 -c -fgpu-rdc "$hip_file" -o "$out_file" 2>&1 | tee "${out_file}.log"; then
        echo "  ✓ Compilation succeeded"
        # Clean up hip file on success (optional)
        # rm "$hip_file"
    else
        echo "  ✗ Compilation failed for $hip_file (see ${out_file}.log)"
    fi
done

echo ""
echo "========================================"
echo "Done processing all .cu files"