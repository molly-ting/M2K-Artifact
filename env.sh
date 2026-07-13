#!/usr/bin/env bash
# Source this file after running setup.sh:
#   source env.sh

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

export LLVM_DIR=/usr/lib/llvm-13
export SIGNED_CLANG_PATH="${PROJECT_DIR}/.deps/llvm-project/build/bin"
export PATH="${PROJECT_DIR}/cuKLEE/build:${PROJECT_DIR}/cuKLEE/klee/build/bin:${LLVM_DIR}/bin:${PATH}"

source "${PROJECT_DIR}/.venv/bin/activate"
