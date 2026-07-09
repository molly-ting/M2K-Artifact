#!/bin/bash
cd "$(dirname "$0")"/..

docker build -t esbmc docker/esbmc
