#!/bin/bash
cd "$(dirname "$0")"/..

docker build -t hip-compiler docker/builder