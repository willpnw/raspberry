#!/bin/bash

set -ex

PROJECT=raspberry

YOCTO_DIR=$(pwd)/yocto

mkdir -p ${YOCTO_DIR}/{build,sources}
test -f ${YOCTO_DIR}/container-runme.sh || cp container-runme.sh ${YOCTO_DIR}/container-runme.sh

make build

eval `ssh-agent -s`
ssh-add
make run CONTAINER_DATA_DIR=$(pwd)/yocto
