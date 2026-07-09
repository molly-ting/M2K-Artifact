#!/bin/bash
set -euo pipefail

SRC_PATH=${1:-}

if [ -z "${SRC_PATH}" ]; then
  echo "❌ Error: No source file or directory provided"
  echo "Usage: docker run --rm -v \$(pwd):/workspace hip-compiler <file.cu|source_dir>"
  exit 1
fi


# Single-file mode: hipify and compile example
BASENAME=$(basename "${SRC_PATH}" .cu)

echo "🔧 Translating ${SRC_PATH} to HIP..."
hipify-perl "${SRC_PATH}" > "${BASENAME}.hip.cpp"

echo "⚙️  Compiling to AMDGPU ELF (gfx1030)..."
hipcc --offload-arch=gfx1030 -O2 -c -fgpu-rdc "${BASENAME}.hip.cpp" -o "${BASENAME}.out"

echo "✅ Done: ${BASENAME}.out (AMDGPU ELF binary)"