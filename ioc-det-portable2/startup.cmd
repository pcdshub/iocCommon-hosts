#!/bin/sh

# Load the USB driver (ftdi)
/sbin/modprobe ftdi_sio
# Give it time to be created, then fix permissions on USB device
echo "Loaded modules:"
/sbin/lsmod | grep ftdi_sio
sleep 1
ls -l /dev | grep USB

/reg/g/pcds/pyps/apps/ioc/latest/initIOC
