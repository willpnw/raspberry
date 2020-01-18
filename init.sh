#!/bin/bash
set -ex

PROJECT=raspberry

YOCTO_DIR=$(pwd)/${PROJECT}-yocto

test -d ${PROJECT}-dockerfile-yocto || git clone git@github.com:willpnw/${PROJECT}-dockerfile-yocto.git

mkdir -p ${YOCTO_DIR}

make -C dockerfile build
#make -C dockerfile docker CONTAINER_DATA_DIR=$(pwd)/yocto
