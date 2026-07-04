#!/bin/bash

# cd "$(dirname "$0")"/..

docker run --rm -v $(pwd):/output honeycomb \
validator $@