#!/bin/bash

set -ex

PROJECT=raspberry

YOCTO_DIR=$(pwd)/yocto

mkdir -p ${YOCTO_DIR}

make build
#make -C dockerfile docker CONTAINER_DATA_DIR=$(pwd)/yocto
