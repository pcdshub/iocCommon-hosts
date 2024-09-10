#!/bin/sh
rdate -s 172.21.32.31
/sbin/modprobe perle-serial
/reg/g/pcds/package/epics/3.14/modules/ev2_driver/latest/driver/evr_load_module

# Load USB driver (ftdi)
/sbin/modprobe ftdi_sio
echo "Loaded USB modules:"
/sbin/lsmod | grep ftdi_sio
sleep 1
ls -l /dev | grep USB

/reg/g/pcds/pyps/apps/ioc/latest/initIOC

