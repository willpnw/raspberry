#!/bin/bash

set -ex


ROOT_DIR=$(pwd)
YOCTO_DIR=${ROOT_DIR}/yocto
DOCKERFILE_DIR=${ROOT_DIR}/dockerfile

make -C ${DOCKERFILE_DIR} build
eval `ssh-agent -s`
ssh-add
make -C ${DOCKERFILE_DIR} run CONTAINER_DATA_DIR=$(pwd)/yocto
