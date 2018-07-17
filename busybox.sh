#!/bin/bash
TGTDIR=busybox
BB_URL=https://busybox.net/downloads/binaries/1.28.1-defconfig-multiarch/busybox-x86_64
DIG_URL=https://github.com/sequenceiq/docker-alpine-dig/releases/download/v9.10.2/dig.tgz

# downloads and installs busybox (https://busybox.net/) and dig
mkdir ${TGTDIR}
cd ${TGTDIR} 
curl ${BB_URL} > busybox
chmod +x busybox

curl -L ${DIG_URL} > dig.tgz
tar -zxvf dig.tgz

