#!/bin/sh

/sbin/modprobe perle-serial
/reg/g/pcds/package/epics/3.14/modules/ev2_driver/latest/driver/evr_load_module

/reg/g/pcds/pyps/apps/ioc/latest/initIOC
