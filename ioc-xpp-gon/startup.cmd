#!/bin/sh

source /reg/d/iocCommon/All/setup_gige.sh

# Load the USB driver (ftdi)
/sbin/modprobe ftdi_sio
# Give it time to be created, then fix permissions on USB device
echo "Loaded modules:"
/sbin/lsmod | grep ftdi_sio
sleep 1
ls -l /dev | grep USB

/reg/g/pcds/pyps/apps/ioc/latest/initIOC

/reg/g/pcds/pkg_mgr/release/procServ/2.8.0-1.0.0/linux-x86_64/bin/procServ --allow --ignore ^D --coresize 0 -c /tmp -l 51000 51001 /bin/sh --noediting -f
