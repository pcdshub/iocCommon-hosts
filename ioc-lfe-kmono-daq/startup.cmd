#!/bin/sh

/etc/init.d/monit stop
rdate -s 172.21.32.31
/reg/g/pcds/package/epics/3.14/modules/event2/R4.0.0-4.2.1/driver/evr_load_module
/reg/g/pcds/pyps/apps/ioc/latest/initIOC
