#!/bin/sh

#source /reg/d/iocCommon/All/setup_gige.sh

if [ ! -e /dev/era0 -a $UID -eq 0 ]
then
        # Load EVR module on startup
        # Must be run as root
        #/usr/local/sbin/module_load
        /reg/g/pcds/package/epics/3.14/modules/ev2_driver/latest/driver/evr_load_module
fi

if [ ! -f /sys/bus/pci/drivers/uio_pci_generic/new_id ]; then
    modprobe uio
    insmod /lib/modules/`uname -r`/kernel/daq/uio_pci_generic.ko
fi

/reg/g/pcds/pyps/apps/ioc/latest/initIOC
