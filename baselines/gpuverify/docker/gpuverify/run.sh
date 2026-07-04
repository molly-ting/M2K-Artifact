#!/bin/env bash
set -e

gpuverify "$@" --clang-opt="-I/usr/local/cuda/include -I/usr/include -I/usr/include/x86_64-linux-gnu"
