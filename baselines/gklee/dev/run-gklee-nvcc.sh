#!/bin/bash

cd "$(dirname "$0")"/..

docker run --rm -v $(pwd):/output gklee \
dev/gklee-nvcc $@