install
url --url=http://mirror.centos.org/centos/7/os/x86_64/
repo --name="Updates" --baseurl=http://mirror.centos.org/centos/7/updates/x86_64/
repo --name="FastTrack" --baseurl=http://mirror.centos.org/centos/7/fasttrack/x86_64/
repo --name="Plus" --baseurl=http://mirror.centos.org/centos/7/centosplus/x86_64/
repo --name="Extras" --baseurl=http://mirror.centos.org/centos/7/extras/x86_64/
repo --name="EPEL" --baseurl=http://dl.fedoraproject.org/pub/epel/7/x86_64/
lang en_US.UTF-8
keyboard uk
network --device eth0 --bootproto dhcp
rootpw --iscrypted $6$ADKSRVN2#$uodhL.fKNvtEx0wD6CR7auAlrd4fMv.kRaqEXebqX1/C8RAYXzK0.9KAHNH9s06h/QyVKeEBXXRzVI46l0Yt30
firewall --service=ssh
authconfig --enableshadow --passalgo=sha512 --enablefingerprint
selinux --enforcing
timezone --utc Europe/London
bootloader --location=mbr --driveorder=vda
zerombr
clearpart --all --initlabel
part /boot --fstype ext4 --size=400
part pv.2 --size=5000 --grow
volgroup VolGroup00 --pesize=32768 pv.2
logvol / --fstype xfs --name=LogVol00 --vgname=VolGroup00 --size=1024 --grow
logvol swap --fstype swap --name=LogVol01 --vgname=VolGroup00 --size=256 --grow --maxsize=512
reboot
%packages --excludedocs --nobase
sudo
openssh-server
openssh-clients
rsync
%end

%post --log=/root/post.log --nochroot
sed -i "s/^ACTIVE_CONSOLES=\/dev\/tty\[1-6\]/ACTIVE_CONSOLES=\/dev\/tty1/" /mnt/sysimage/etc/sysconfig/init

sed -i "/HWADDR/d" /mnt/sysimage/etc/sysconfig/network-scripts/ifcfg-eth*
rm -f /mnt/sysimage//etc/udev/rules.d/*-persistent-net.rules
touch /mnt/sysimage/etc/udev/rules.d/75-persistent-net-generator.rules
echo NOZEROCONF=yes >> /mnt/sysimage/etc/sysconfig/network

sed -i 's/rhgb quiet/quiet console=tty0 console=ttyS0,115200n8/g' /mnt/sysimage/boot/grub/grub.conf
sed -i 's/^hiddenmenu$/hiddenmenu\nserial\ --unit=0\ --speed=115200\ --word=8\ --parity=no\ --stop=1\nterminal\ --timeout=5\ console\ serial/g' /mnt/sysimage/boot/grub/grub.conf

chroot /mnt/sysimage /usr/sbin/groupadd vagrant
chroot /mnt/sysimage /usr/sbin/useradd -g vagrant -m vagrant
mkdir /mnt/sysimage/home/vagrant/.ssh
cat > /mnt/sysimage/home/vagrant/.ssh/authorized_keys <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key
EOF
chmod 0700 /mnt/sysimage/home/vagrant/.ssh
chmod 0600 /mnt/sysimage/home/vagrant/.ssh/authorized_keys
chroot /mnt/sysimage chown vagrant:vagrant /mnt/sysimage/home/vagrant/.ssh /mnt/sysimage/home/vagrant/.ssh/authorized_keys
cat > /mnt/sysimage/etc/sudoers.d/vagrant <<EOF
vagrant ALL=(ALL) NOPASSWD: ALL
Defaults:vagrant !requiretty
EOF
chmod 0400 /mnt/sysimage/etc/sudoers.d/vagrant

rm -f /mnt/sysimage/root/*
%end
