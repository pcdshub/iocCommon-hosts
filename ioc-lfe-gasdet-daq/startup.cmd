#!/bin/sh
#/reg/g/pcds/package/epics/3.14/modules/event2/R4.0.0-4.2.1/driver/evr_load_module
/etc/init.d/monit stop
rdate -s 172.21.32.31
#mount psnfs04:/nfsexport/datapool/pcds /reg/g/pcds
/reg/g/pcds/pyps/apps/ioc/latest/initIOC
