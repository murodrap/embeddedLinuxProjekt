#!/bin/sh

git clone https://github.com/buildroot/buildroot
cd buildroot
git apply ../mediaplayer3.patch
make raspberrypi_defconfig
make

echo "dtparam=audio=on" >> output/images/rpi-firmware/config.txt
echo "sd[a-z][0-9]* root:root 660 @/etc/mdev/mount.sh add \$MDEV" >> output/target/etc/mdev.conf
#echo "sd[a-z][0-9]* root:root 660 $/etc/mdev/mount.sh remove \$MDEV" >> output/target/etc/mdev.conf
mkdir output/target/etc/mdev
cp ../mount.sh output/target/etc/mdev/mount.sh
chmod a+x output/target/etc/mdev/mount.sh
make
