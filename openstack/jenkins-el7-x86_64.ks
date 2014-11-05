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
rootpw --iscrypted $1$UKLtvLuY$kka6S665oCFmU7ivSDZzU.
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
cloud-init
epel-release
mock
unzip
git
subversion
mercurial
java
gcc-c++
gcc
libffi-devel
make
wget
yum-utils
%end

%post --log=/root/post.log --nochroot
sed -i "s/^ACTIVE_CONSOLES=\/dev\/tty\[1-6\]/ACTIVE_CONSOLES=\/dev\/tty1/" /mnt/sysimage/etc/sysconfig/init

sed -i "/HWADDR/d" /mnt/sysimage/etc/sysconfig/network-scripts/ifcfg-eth*
rm -f /mnt/sysimage//etc/udev/rules.d/*-persistent-net.rules
touch /mnt/sysimage/etc/udev/rules.d/75-persistent-net-generator.rules
echo NOZEROCONF=yes >> /mnt/sysimage/etc/sysconfig/network

sed -i 's/rhgb quiet/quiet console=tty0 console=ttyS0,115200n8/g' /boot/grub/grub.conf
sed -i 's/^hiddenmenu$/hiddenmenu\nserial\ --unit=0\ --speed=115200\ --word=8\ --parity=no\ --stop=1\nterminal\ --timeout=5\ console\ serial/g' /boot/grub/grub.conf

#handle the cloud-init stuff
echo 'disable_root: 0' > /etc/cloud/cloud.cfg.d/01_centos.cfg
echo 'user: root' >> /etc/cloud/cloud.cfg.d/01_centos.cfg

rm -f /mnt/sysimage/root/*
%end

%post
useradd -g mock -s /bin/bash -m jenkins
mkdir /home/jenkins/.ssh
chown jenkins:jenkins /home/jenkins/.ssh
chmod 700 /home/jenkins/.ssh
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA0kDAVYQ7sL8ekiSlZV15a/Vs8niGFP1HJIFVnVpEk01XiFSeFtgaHekV+xAhDM7HgwaemV8QnvfcUDB25JcmosHo5vmHsRpLVt3uxXVmNufPluyoz2l4BUQc7hzr8Lwno9pZnBu0wq7W8MaxdofHF8q4dwdk+3ZrybHsw6qwcAxmuXXQxTdt7EJDsqTPDU9V+vpCtQRt07YcHjSO0/IaBM6WYjV3bFT0MnwBT0wX5DS9T8TpWXc61tpXQLBkplolQhwBmgV2PaTUodC5oMwD8JVPnIWxYzGd/vtNbdEzDzxCHdzn4E2J9kxwZLAvmIJhN0WDv74oLfCYDEsTQnKe1Q== dmlb2000@c0' > /home/jenkins/.ssh/authorized_keys
chmod 600 /home/jenkins/.ssh/authorized_keys
yum -y install https://opscode-omnibus-packages.s3.amazonaws.com/el/6/x86_64/chefdk-0.3.0-1.x86_64.rpm
yum -y install https://dl.bintray.com/mitchellh/vagrant/vagrant_1.6.5_x86_64.rpm
su - jenkins -c '/opt/chefdk/embedded/bin/gem install knife-openstack kitchen-openstack knife-backup'
su - jenkins -c 'vagrant plugin install vagrant-openstack-provider'
su - jenkins -c 'vagrant plugin install vagrant-berkshelf'
%end
