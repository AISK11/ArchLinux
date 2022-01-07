#!/bin/bash

## Check if make command was run as root:
if [[ $(whoami) != "root" ]]; then
	echo "Run this Makefile as root!"
	exit
fi

## Get UUID of root device and replace '<UUID>' string in local grub file
SED_TEMP_VARIABLE=$(blkid | grep "/dev/mapper/vg0-root" | egrep -o "UUID=\".*\"" | cut -d '"' -f 2)
sed -i "s/<UUID>/${SED_TEMP_VARIABLE}/g" ./files/grub

## Copy local files to their destinations and set file permissions:
cp ./files/grub			/etc/default/grub
cp ./files/31_hold_shift	/etc/grub.d/31_hold_shift
chmod 0775			/etc/grub.d/31_hold_shift

## Generate new grub config file:
grub-mkconfig -o /boot/grub/grub.cfg
