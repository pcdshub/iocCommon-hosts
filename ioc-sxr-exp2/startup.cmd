#!/bin/sh

/sbin/rmmod arcus
sleep 5
/sbin/insmod /reg/g/pcds/package/epics/3.14/ioc/common/arcus/R1.0.0/driver/arcus.ko

/reg/g/pcds/pyps/apps/ioc/latest/initIOC
