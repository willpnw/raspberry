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
test -d .repo || repo init -u git@github.com:willpnw/raspberry-manifest.git

repo sync

# ONE TIME REPO SETUP
#repo init -u git@bitbucket.org:adeneo-embedded/tablesafe-manifests.git

# ONE TIME SETUP LOCAL MANIFEST
#mkdir .repo/local_manifests/
#cat <<EOF > .repo/local_manifests/local_manifest.xml
#<?xml version="1.0" encoding="UTF-8"?>
#<manifest>
#    <remove-project name="tablesafe-meta-tablesafe.git" />
#    <project name="tablesafe-meta-tablesafe.git" remote="witekio" path="meta-tablesafe" revision="sbach/develop"/>
#</manifest>
#EOF

# ONE TIME REPO SETUP
#repo sync

# ONE TIME SETUP THE LOCAL CONF
#cat <<EOF >> conf/local.conf
#
## Override Git branches used for various packages.
#KBRANCH = "broadcom/ga-3.7-bcm583xx"
#SRCBRANCH_pn-boot1 = "broadcom/ga-3.7-bcm583xx"
#SRCBRANCH_pn-secimage-native = "broadcom/ga-3.7-bcm583xx"
#SRCBRANCH_pn-u-boot-tablesafe = "broadcom/ga-3.7-bcm583xx"
#
#INHERIT += "buildhistory"
#BUILDHISTORY_COMMIT = "1"
#EOF


# SETUP THE BUILD ENV AND BITBAKE SYSTEM IMAGE
set +x
echo ". sources/oe-init-build-env build"
echo "bitbake core-image-base"
