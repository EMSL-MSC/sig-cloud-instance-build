#!/bin/bash -xe

TMP_KS=$(mktemp)

# install the kickstart by url in $1
curl -L "$1" > $TMP_KS
URL=$(grep ^url $TMP_KS  | head -n 1 | cut -d= -f2)
ARCH=$(basename $URL)
virt-install --connect=qemu:///system -n $(basename ${1/.ks/}) --ram 2048 --vcpus 1 -l $URL -x "ks=$1 serial text console=ttyS0" --disk path=/var/lib/libvirt/images/$(basename ${1/.ks/}).qcow2,size=8,format=qcow2 -w network=default --console pty --virt-type kvm --arch $ARCH --noreboot --noautoconsole
