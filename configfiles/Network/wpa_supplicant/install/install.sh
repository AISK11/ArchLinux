!/bin/bash

## Check if make command was run as root:
if [[ $(whoami) != "root" ]]; then
	echo "Run this Makefile as root!"
	exit
fi

## Copy local files to their destinations and set file permissions:
cp ./files/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf
