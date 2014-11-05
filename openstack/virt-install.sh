#!/bin/bash -xe

TOPDIR=$(dirname $0)

# install the kickstart by url in $1
URL=$(grep ^url $TOPDIR/$1  | head -n 1 | cut -d= -f2)
ARCH=$(basename $URL)
virt-install --connect=qemu:///system \
    -n ${1/.ks/} \
    --ram 2048 \
    --vcpus 1 \
    -l $URL \
    --initrd-inject=$TOPDIR/$1 \
    -x "ks=/$1 serial text console=ttyS0" \
    --disk path=/var/lib/libvirt/images/${1/.ks/}.qcow2,size=8,format=qcow2 \
    -w network=default \
    --console pty \
    --virt-type kvm \
    --arch $ARCH \
    --noreboot --noautoconsole
