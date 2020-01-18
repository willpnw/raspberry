#!/bin/bash

set -ex

PROJECT=raspberry

YOCTO_DIR=$(pwd)/yocto

mkdir -p ${YOCTO_DIR}/{build/conf,sources}

test -f ${YOCTO_DIR}/container-runme.sh       || cp container-runme.sh ${YOCTO_DIR}/container-runme.sh
test -f ${YOCTO_DIR}/build/conf/bblayers.conf || cp bblayers.conf ${YOCTO_DIR}/build/conf/bblayers.conf
test -f ${YOCTO_DIR}/build/conf/local.conf    || cp local.conf ${YOCTO_DIR}/build/conf/local.conf

make build

eval `ssh-agent -s`
ssh-add
make run CONTAINER_DATA_DIR=$(pwd)/yocto
