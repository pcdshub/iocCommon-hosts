#!/bin/sh

# Configure this host for gigE camera support
source /reg/d/iocCommon/All/setup_gige.sh

# Load the USB driver (ftdi)
/sbin/modprobe ftdi_sio

echo "Loaded modules:"
/sbin/lsmod | grep ftdi_sio
sleep 1
ls -l /dev | grep USB

# Increase usbfs_memory_mb from default needed for usb3 cameras (e.g. Alvium, Zyla)
echo "1024" > /sys/module/usbcore/parameters/usbfs_memory_mb

# fix unicast ca discovery on host
/cds/group/pcds/dist/pds/boot/epics-ca-unicast-fix.sh

/reg/g/pcds/pyps/apps/ioc/latest/initIOC
