#!/bin/sh

if [ ! -e /dev/era0 -a $UID -eq 0 ]
then
        # Load EVR module on startup
        # Must be run as root
        #/usr/local/sbin/module_load
        /reg/g/pcds/package/epics/3.14/modules/ev2_driver/R1.0.1/driver/evr_load_module
fi

/reg/g/pcds/pyps/apps/ioc/latest/initIOC

