#!/bin/sh
echo Loading datadev module

/reg/g/pcds/dist/pds/boot/datadev_load_module v5.16.0

/reg/g/pcds/pyps/apps/ioc/latest/initIOC
