#!/bin/sh

# Load the USB driver
/sbin/modprobe cp210x
# Give it time to be created, then fix permissions on USB device
echo "Loaded modules:"
/sbin/lsmod | grep cp210
sleep 1
ls -l /dev | grep USB
echo "Changing permissions to:"
chmod a+rw /dev/ttyUSB0
ls -l /dev | grep USB

/reg/g/pcds/pyps/apps/ioc/latest/initIOC
