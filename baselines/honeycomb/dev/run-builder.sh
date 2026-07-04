#!/bin/bash

cd "$(dirname "$0")"/../..

# docker run --rm -v $(pwd):/workspace  $@

docker run -u $(id -u):$(id -g) --rm -v $(pwd):/workspace hip-compiler hipify_directory.py $@