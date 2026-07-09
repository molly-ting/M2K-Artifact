#!/bin/bash

# Script to compile .cu files under src/ using gklee-nvcc (compile-cu)
# Usage: ./build.sh [file.cu]
#   - If file.cu is provided, compile only that file
#   - Otherwise, compile all .cu files in src/

set -e  # Exit on error

# Directories
SRC_DIR="./src"
OUTPUT_DIR="./srcbin"
GKLEE_COMPILE="gklee-nvcc"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Check if KLEE_HOME_DIR is set
if [ -z "$KLEE_HOME_DIR" ]; then
    echo "Error: KLEE_HOME_DIR is not set!"
    echo "Please set it to your GKLEE installation directory."
    exit 1
fi

# Check if src directory exists
if [ ! -d "$SRC_DIR" ]; then
    echo "Error: Source directory $SRC_DIR does not exist!"
    exit 1
fi

# Counter for tracking progress
total=0
success=0
failed=0

# Determine which files to compile
if [ -n "$1" ]; then
    # Single file mode
    if [ -f "$1" ]; then
        cu_files=("$1")
        echo "Compiling single file: $1"
    elif [ -f "$SRC_DIR/$1" ]; then
        cu_files=("$SRC_DIR/$1")
        echo "Compiling single file: $SRC_DIR/$1"
    else
        echo "Error: File $1 not found!"
        exit 1
    fi
else
    # All files mode
    echo "Starting compilation of all .cu files in $SRC_DIR..."
    cu_files=("$SRC_DIR"/*.cu)
fi

echo "Output will be placed in $OUTPUT_DIR"
echo "----------------------------------------"

for cu_file in "${cu_files[@]}"; do
    # Check if any .cu files exist
    if [ ! -e "$cu_file" ]; then
        echo "No .cu files found in $SRC_DIR"
        exit 0
    fi
    
    # Get the base filename without extension
    base_name=$(basename "$cu_file" .cu)
    output_name="$OUTPUT_DIR/$base_name"
    
    echo "Compiling: $cu_file -> $output_name"
    
    total=$((total + 1))
    
    # Compile the file
    if $GKLEE_COMPILE "$cu_file" -o "$output_name"; then
        success=$((success + 1))
        echo "  ✓ Success: $base_name"
        
        # Move generated files to output directory
        if [ -f "${base_name}.cpp" ]; then
            mv "${base_name}.cpp" "$OUTPUT_DIR/"
        fi
        if [ -f "${base_name}.kernelSet.txt" ]; then
            mv "${base_name}.kernelSet.txt" "$OUTPUT_DIR/${base_name}.kernelSet.txt"
        fi

    else
        failed=$((failed + 1))
        echo "  ✗ Failed: $base_name"
    fi
    
    echo ""
done

echo "----------------------------------------"
echo "Compilation Summary:"
echo "  Total:   $total"
echo "  Success: $success"
echo "  Failed:  $failed"
echo "----------------------------------------"

if [ $failed -eq 0 ]; then
    echo "All files compiled successfully!"
    exit 0
else
    echo "Some files failed to compile."
    exit 1
fi