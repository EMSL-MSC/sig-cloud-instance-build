#!/bin/bash -xe

TMP_KS=$(mktemp)

# install the kickstart by url in $1
curl "$1" > $TMP_KS
URL=$(grep ^url $TMP_KS  | head -n 1 | cut -d= -f2)
ARCH=$(basename $URL)
virt-install -n $(basename ${1/.ks/}) --memory 2048 --vcpus 1 -l $URL -x "ks=$1 serial text" --disk size=8 -w bridge=br0 --serial pty --virt-type kvm --arch $ARCH --noreboot
