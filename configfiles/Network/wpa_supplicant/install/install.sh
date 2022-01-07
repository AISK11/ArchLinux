#!/bin/bash

## Check if make command was run as root:
if [[ $(whoami) != "root" ]]; then
	echo "Run this Makefile as root!"
	exit
fi

## Copy local files to their destinations and set file permissions:
cp ./files/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf &&
echo -e "[+]   WPA supplicant configuration file was copied to '/etc/wpa_supplicant/wpa_supplicant.conf'." ||
echo -e "[-] ! ERROR! WPA supplicant configuration file could not be copied to '/etc/wpa_supplicant/wpa_supplicant.conf'!"

chmod 0600 /etc/wpa_supplicant/wpa_supplicant.conf &&
echo -e "[+]   WPA supplicant configuration file (/etc/wpa_supplicant/wpa_supplicant.conf) permission secured to 0600." ||
echo -e "[-] ! ERROR! WPA supplicant configuration file (/etc/wpa_supplicant/wpa_supplicant.conf) permission could not be secured to 0600.!"
