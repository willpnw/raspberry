#!/bin/bash

set -ex

# SETUP SSH KEYS
mkdir -p ~/.ssh
ssh-keygen -F bitbucket.org || ssh-keyscan -t rsa bitbucket.org >> ~/.ssh/known_hosts
ssh-keygen -F github.com || ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

# GIT CONFIG
git config --global user.name "Will Patterson"
git config --global user.email "wpatterson@witekio.com"

cd sources
test -d .repo || repo init -u git@github.com:willpnw/raspberry.git

repo sync

# SETUP THE BUILD ENV AND BITBAKE SYSTEM IMAGE
set +x
echo ""
echo ""
echo ""
echo ""
echo ""
echo ". sources/oe-init-build-env build"
echo "bitbake core-image-base"
