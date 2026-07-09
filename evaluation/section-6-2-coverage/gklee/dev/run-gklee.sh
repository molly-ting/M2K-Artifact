#!/bin/bash

cd "$(dirname "$0")"/..

docker run --rm -v $(pwd):/workspace gklee \
gklee $@