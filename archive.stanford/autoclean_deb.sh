#!/bin/bash

OLDCONF=$(dpkg -l|grep "^rc"|awk '{print $2}')
CURKERNEL=$(uname -r|sed 's/-*[a-z]//g'|sed 's/-386//g')
LINUXPKG="linux-(image|headers|ubuntu-modules|restricted-modules)"
METALINUXPKG="linux-(image|headers|restricted-modules)-(generic|i386|server|common|rt|xen)"
OLDKERNELS=$(dpkg -l|awk '{print $2}'|grep -E $LINUXPKG |grep -vE $METALINUXPKG|grep -v $CURKERNEL)
YELLOW="\033[1;33m"
RED="\033[0;31m"
ENDCOLOR="\033[0m"

if [ $USER != root ]; then
echo -e $RED"Error: must be root"
echo -e $YELLOW"Exiting..."$ENDCOLOR
exit 0
fi

echo -e $YELLOW"Cleaning apt cache..."$ENDCOLOR
apt-get clean
apt-get autoclean

echo -e $YELLOW"Removing old config files..."$ENDCOLOR
apt-get purge $OLDCONF

echo -e $YELLOW"Removing old kernels..."$ENDCOLOR
apt-get purge $OLDKERNELS

echo -e $YELLOW"Script Finished!"$ENDCOLOR
