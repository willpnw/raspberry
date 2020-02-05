#!/bin/bash

set -ex

# SETUP SSH KEYS
mkdir -p ~/.ssh
for host in bitbucket.org github.com code.qt.io; do
    ssh-keygen -F $host || ssh-keyscan -t rsa $host >> ~/.ssh/known_hosts
done

# GIT CONFIG
git config --global user.name "Will Patterson"
git config --global user.email "wpatterson@witekio.com"

#test -d .repo || repo init -u git@github.com:willpnw/raspberry.git
test -d .repo || repo init -u git://code.qt.io/yocto/boot2qt-manifest -m v5.13.2.xml
repo sync

# SETUP THE BUILD ENV AND BITBAKE SYSTEM IMAGE
set +x
echo ""
echo ""
echo "export MACHINE=raspberrypi3"
echo "source ./setup-environment.sh build"
echo "bitbake b2qt-embedded-qt5-image"
