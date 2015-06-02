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
patch
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
bzip2
docker
%end

%post --log=/root/post.log --nochroot
sed -i "s/^ACTIVE_CONSOLES=\/dev\/tty\[1-6\]/ACTIVE_CONSOLES=\/dev\/tty1/" /mnt/sysimage/etc/sysconfig/init

sed -i "/HWADDR/d" /mnt/sysimage/etc/sysconfig/network-scripts/ifcfg-eth*
rm -f /mnt/sysimage//etc/udev/rules.d/*-persistent-net.rules
touch /mnt/sysimage/etc/udev/rules.d/75-persistent-net-generator.rules
echo NOZEROCONF=yes >> /mnt/sysimage/etc/sysconfig/network

sed -i 's/rhgb quiet/quiet console=tty0 console=ttyS0,115200n8/g' /mnt/sysimage/boot/grub/grub.conf
sed -i 's/^hiddenmenu$/hiddenmenu\nserial\ --unit=0\ --speed=115200\ --word=8\ --parity=no\ --stop=1\nterminal\ --timeout=5\ console\ serial/g' /mnt/sysimage/boot/grub/grub.conf
%end

%post
set -x
exec 1>/var/log/ks-post.log 2>&1
chkconfig docker on
groupadd --system docker
useradd -g mock -G docker -s /bin/bash -m centos
yum -y install https://opscode-omnibus-packages.s3.amazonaws.com/el/6/x86_64/chefdk-0.5.1-1.el6.x86_64.rpm
yum -y install https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.2_x86_64.rpm
curl -o /tmp/foo.zip https://dl.bintray.com/mitchellh/packer/packer_0.7.5_linux_amd64.zip
pushd /usr/local/bin
unzip /tmp/foo.zip
popd
rm -f /tmp/foo.zip
su - centos -c '/opt/chefdk/embedded/bin/gem install knife-openstack kitchen-openstack knife-backup'
su - centos -c 'vagrant plugin install vagrant-openstack-provider'
su - centos -c 'vagrant plugin install vagrant-berkshelf'
%end
