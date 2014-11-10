#!/bin/bash -xe

BUILDDIR=$(mktemp -d --tmpdir $PWD)

cat >$BUILDDIR/Vagrantfile <<EOF
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.provider :libvirt do |libvirt|
    libvirt.driver = "kvm"
    libvirt.host = "localhost"
    libvirt.connect_via_ssh = false
    libvirt.username = "root"
    libvirt.storage_pool_name = "default"
EOF

cat >$BUILDDIR/metadata.json <<EOF
{
  "provider"     : "libvirt",
  "format"       : "qcow2",
  "virtual_size" : 8
}
EOF

virsh -c qemu:///system vol-download --pool default $1.qcow2 $BUILDDIR/box.img
tar -czf $1.box -C $BUILDDIR ./metadata.json ./Vagrantfile ./box.img
rm -rf $BUILDDIR
