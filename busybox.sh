#!/bin/bash

mkdir t
cd t
curl https://busybox.net/downloads/binaries/1.28.1-defconfig-multiarch/busybox-x86_64 > busybox
chmod +x busybox

curl -L https://github.com/sequenceiq/docker-alpine-dig/releases/download/v9.10.2/dig.tgz > dig.tgz
tar -zxvf dig.tgz

