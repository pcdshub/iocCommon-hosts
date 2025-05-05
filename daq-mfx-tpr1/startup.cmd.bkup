#!/bin/sh

# Configure this host for gigE camera support
source /reg/d/iocCommon/All/setup_gige.sh

/reg/g/pcds/pyps/apps/ioc/latest/initIOC

# Load the USB driver (ftdi)
/sbin/modprobe ftdi_sio

echo "Loaded modules:"
/sbin/lsmod | grep ftdi_sio
sleep 1
ls -l /dev | grep USB
