#!/bin/bash

## Check if make command was run as root:
if [[ $(whoami) != "root" ]]; then
	echo "Run this Makefile as root!"
	exit
fi

## Get UUID of root device and replace '<UUID>' string in local grub file
SED_TEMP_VARIABLE=$(blkid | grep "/dev/mapper/vg0-root" | egrep -o "UUID=\".*\"" |cut -d '"' -f 2)
sed -i "s/<UUID>/${SED_TEMP_VARIABLE}/g" ./grub

## Copy local files to their destination and set file permissions:
cp ./grub        /etc/default/grub
cp 31_hold_shift /etc/grub.d/31_hold_shift
chmod 0775       /etc/grub.d/31_hold_shift

## Generate new grub config file:
grub-mkconfig -o /boot/grub/grub.cfg
