#!/bin/bash

## Check if make command was run as root:
if [[ $(whoami) != "root" ]]; then
	echo "Run this Makefile as root!"
	exit
fi

## Copy local file to their destinations :
cp ./files/dhcpcd.conf /etc/dhcpcd.conf &&
echo -e "[+]   DHCP configuration file was copied to '/etc/dhcpcd.conf'." ||
echo -e "[-] ! ERROR! DHCP configuration file could not be copied to '/etc/dhcpcd.conf'!"
