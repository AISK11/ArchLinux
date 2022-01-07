#!/bin/bash

## Check if make command was run as root:
if [[ $(whoami) != "root" ]]; then
	echo "Run this Makefile as root!"
	exit
fi

## Copy local file to their destinations :
cp ./files/dhcpcd.conf /etc/dhcpcd.conf
