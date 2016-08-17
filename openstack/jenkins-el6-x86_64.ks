install
url --url=http://mirror.centos.org/centos/6/os/x86_64/
lang en_US.UTF-8
keyboard uk
network --device eth0 --bootproto dhcp
rootpw --iscrypted $1$UKLtvLuY$kka6S665oCFmU7ivSDZzU.
firewall --service=ssh
authconfig --enableshadow --passalgo=sha512 --enablefingerprint
selinux --enforcing
timezone --utc Europe/London
bootloader --location=mbr --driveorder=sda
repo --name="CentOS" --baseurl=http://mirror.centos.org/centos/6/os/x86_64/ --cost=100
repo --name="CentOS Plus" --baseurl=http://mirror.centos.org/centos/6/centosplus/x86_64/ --cost=100
repo --name="CentOS Updates" --baseurl=http://mirror.centos.org/centos/6/updates/x86_64/ --cost=100
repo --name="CentOS FastTrack" --baseurl=http://mirror.centos.org/centos/6/fasttrack/x86_64/ --cost=100
repo --name="CentOS Extras" --baseurl=http://mirror.centos.org/centos/6/extras/x86_64/ --cost=100
repo --name="EPEL" --baseurl=http://dl.fedoraproject.org/pub/epel/6/x86_64/ --cost=100
zerombr yes
clearpart --all --initlabel
part /boot --fstype ext3 --size=400
part pv.2 --size=5000 --grow
volgroup VolGroup00 --pesize=32768 pv.2
logvol / --fstype ext4 --name=LogVol00 --vgname=VolGroup00 --size=1024 --grow
logvol swap --fstype swap --name=LogVol01 --vgname=VolGroup00 --size=256 --grow --maxsize=512
reboot
%packages  --excludedocs
@Base
@Core
-bfa-firmware-3.0.3.1-1.el6.noarch
-iwl1000-firmware-39.31.5.1-1.el6.noarch
-ql2400-firmware-5.08.00-1.el6.noarch
-libertas-usb8388-firmware-5.110.22.p23-3.1.el6.noarch
-zd1211-firmware-1.4-4.el6.noarch
-ql2200-firmware-2.02.08-3.1.el6.noarch
-ipw2200-firmware-3.1-4.el6.noarch
-iwl5150-firmware-8.24.2.2-1.el6.noarch
-iwl6050-firmware-41.28.5.1-2.el6.noarch
-iwl6000g2a-firmware-17.168.5.3-1.el6.noarch
-iwl6000-firmware-9.221.4.1-1.el6.noarch
-iwl5000-firmware-8.83.5.1_1-1.el6_1.1.noarch
-ivtv-firmware-20080701-20.2.noarch
-xorg-x11-drv-ati-firmware-6.99.99-1.el6.noarch
-atmel-firmware-1.3-7.el6.noarch
-iwl4965-firmware-228.61.2.24-2.1.el6.noarch
-iwl3945-firmware-15.32.2.9-4.el6.noarch
-rt73usb-firmware-1.8-7.el6.noarch
-ql23xx-firmware-3.03.27-3.1.el6.noarch
-iwl100-firmware-39.31.5.1-1.el6.noarch
-aic94xx-firmware-30-2.el6.noarch
-ql2100-firmware-1.19.38-3.1.el6.noarch
-ql2500-firmware-5.08.00-1.el6.noarch
-rt61pci-firmware-1.2-7.el6.noarch
-ipw2100-firmware-1.3-11.el6.noarch
-b43-fwcutter
-b43-openfwwf
-perl
-perl-Module-Pluggable
-perl-Pod-Escapes
-perl-Pod-Simple
-perl-libs
-perl-version
-vim-enhanced
-abrt
-abrt-addon-ccpp
-abrt-addon-kerneloops
-abrt-addon-python
-abrt-cli
-abrt-libs
-abrt-tui
-libreport
-libreport-cli
-libreport-compat
-libreport-plugin-kerneloops
-libreport-plugin-logger
-libreport-plugin-mailx
-libreport-plugin-reportuploader
-libreport-plugin-rhtsupport
-libreport-python
-cups-libs
-fprintd
-fprintd-pam
-gtk2
-libfprint
-mysql-libs
-cronie
-cronie-anacron
-crontabs
-postfix
-sysstat
-alsa-lib
-alsa-utils
-man
-man-pages
-man-pages-overrides
-yum-utils
-system-config-firewall-base
-system-config-firewall-tui
-system-config-network-tui
-systemtap-runtime
-at
-atk
-avahi-libs
-bc
-bind-libs
-bind-utils
-biosdevname
-blktrace
-busybox
-cairo
-centos-indexhtml
-ConsoleKit
-ConsoleKit-libs
-cpuspeed
-crda
-cyrus-sasl-plain
-dbus
-dbus-python
-desktop-file-utils
-dmidecode
-dmraid
-dmraid-events
-dosfstools
-ed
-eggdbus
-eject
-elfutils-libs
-fontconfig
-freetype
-gnutls
-hal
-hal-info
-hal-libs
-hdparm
-hicolor-icon-theme
-hunspell
-hunspell-en
-irqbalance
-iw
-jasper-libs
-kexec-tools
-ledmon
-libjpeg-turbo
-libnl
-libpcap
-libpng
-libtasn1
-libthai
-libtiff
-libusb1
-libX11
-libX11-common
-libXau
-libxcb
-libXcomposite
-libXcursor
-libXdamage
-libXext
-libXfixes
-libXft
-libXi
-libXinerama
-libxml2-python
-libXrandr
-libXrender
-lsof
-mailx
-microcode_ctl
-mlocate
-mtr
-nano
-ntp
-ntpdate
-ntsysv
-numactl
-pam_passwdqc
-pango
-parted
-pciutils
-pcmciautils
-pinfo
-pixman
-pkgconfig
-pm-utils
-polkit
-prelink
-psacct
-python-ethtool
-python-iwlib
-quota
-rdate
-readahead
-rfkill
-rng-tools
-rsync
-scl-utils
-setserial
-setuptool
-sg3_utils-libs
-sgpio
-smartmontools
-sos
-strace
-tcpdump
-tcp_wrappers
-tcsh
-time
-tmpwatch
-traceroute
-unzip
-usbutils
-usermode
-vconfig
-wget
-wireless-tools
-words
-xdg-utils
-xz
-xz-lzma-compat
-yum-plugin-security
-yum-utils
-zip
patch
bzip2
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

sed -i 's/rhgb quiet/quiet console=tty0 console=ttyS0,115200n8/g' /mnt/sysimage/boot/grub/grub.conf
sed -i 's/^hiddenmenu$/hiddenmenu\nserial\ --unit=0\ --speed=115200\ --word=8\ --parity=no\ --stop=1\nterminal\ --timeout=5\ console\ serial/g' /mnt/sysimage/boot/grub/grub.conf

%end

%post
set -x
exec 1>/var/log/ks-post.log 2>&1
useradd -g mock -s /bin/bash -m centos
yum -y install https://opscode-omnibus-packages.s3.amazonaws.com/el/6/x86_64/chefdk-0.16.28-1.el6.x86_64.rpm
yum -y install https://dl.bintray.com/mitchellh/vagrant/vagrant_1.8.5_x86_64.rpm
su - centos -c '/opt/chefdk/embedded/bin/gem install knife-openstack'
su - centos -c '/opt/chefdk/embedded/bin/gem install kitchen-openstack -v 1.8.1'
su - centos -c '/opt/chefdk/embedded/bin/gem install knife-backup'
su - centos -c 'vagrant plugin install vagrant-openstack-provider'
su - centos -c 'vagrant plugin install vagrant-berkshelf'
%end
