#!/bin/bash

mkdir t
cd t
curl https://busybox.net/downloads/binaries/1.28.1-defconfig-multiarch/busybox-x86_64 > busybox
chmod +x busybox
