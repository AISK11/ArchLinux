#!/bin/bash

## Check if make command was run as root:
if [[ $(whoami) != "root" ]]; then
	echo "Run this Makefile as root!"
	exit
fi

## Get UUID of root device and replace '<UUID>' string in local grub file
SED_TEMP_VARIABLE=$(blkid | egrep 'TYPE="crypto_LUKS".*PARTLABEL="LUKS"' | egrep -o "UUID=\".*\"" | cut -d '"' -f 2) &&
sed -i "s/<LUKS_UUID>/${SED_TEMP_VARIABLE}/g" ./files/grub &&
echo -e "[+]   LUKS encrypted UUID found ('${SED_TEMP_VARIABLE}')." ||
echo -e "[-] ! ERROR! LUKS encrypted UUID was not found!"

## Copy local files to their destinations and set file permissions:
cp ./files/grub			/etc/default/grub &&
echo -e "[+]   Grub config file copied to '/etc/default/grub'." ||
echo -e "[-] ! ERROR! Grub config file could not be copied to '/etc/default/grub'!"

cp ./files/31_hold_shift	/etc/grub.d/31_hold_shift &&
echo -e "[+]   Grub hold shift extension file copied to '/etc/grub.d/31_hold_shift'." ||
echo -e "[-] ! ERROR! Grub hold shift extension file could not be copied to '/etc/grub.d/31_hold_shift'!"

chmod 0775			/etc/grub.d/31_hold_shift &&
echo -e "[+]   Changed hold shift extension file (/etc/grub.d/31_hold_shift) permissions to 0755." ||
echo -e "[-] ! ERROR! Could not change hold shift extension file (/etc/grub.d/31_hold_shift) permissions to 0755!"

## Generate new grub config file:
grub-mkconfig -o /boot/grub/grub.cfg &&
echo -e "[+]   New GRUB configuration was generated ('/boot/grub/grub.cfg')." ||
echo -e "[-] ! ERROR! New GRUB configuration could not be generated ('/boot/grub/grub.cfg')!"
