#!/bin/sh

/reg/g/pcds/package/epics/3.14/modules/ev2_driver/latest/driver/evr_load_module
/etc/init.d/acqiris start

/reg/g/pcds/pyps/apps/ioc/latest/initIOC
