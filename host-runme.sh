#!/bin/bash

set -ex

PROJECT=raspberry

ROOT_DIR=$(pwd)
YOCTO_DIR=${ROOT_DIR}/yocto
DOCKERFILE_DIR=${ROOT_DIR}/dockerfile

mkdir -p ${YOCTO_DIR}/{build/conf,sources}

if [ ! -f ${YOCTO_DIR}/container-runme.sh ] ; then
    cd ${YOCTO_DIR}
    ln -s ${ROOT_DIR}/container-runme.sh
fi

if [ ! -f ${YOCTO_DIR}/build/conf/bblayers.conf ] ; then
    cd ${YOCTO_DIR}/build/conf
    ln -s ${ROOT_DIR}/bblayers.conf
fi

if [ ! -f ${YOCTO_DIR}/build/conf/local.conf ] ; then
    cd ${YOCTO_DIR}/build/conf
    ln -s ${ROOT_DIR}/local.conf
fi

make -C ${DOCKERFILE_DIR} build

eval `ssh-agent -s`
ssh-add
make -C ${DOCKERFILE_DIR} run CONTAINER_DATA_DIR=$(pwd)/yocto
