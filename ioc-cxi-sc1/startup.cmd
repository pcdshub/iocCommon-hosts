#!/bin/sh

/sbin/rmmod arcus
sleep 5
#/sbin/insmod /reg/g/pcds/package/epics/3.14/ioc/common/arcus/R1.0.0/driver/arcus.ko
/sbin/insmod /cds/home/m/mcbrowne/trunk2/ioc/common/arcus/driver7/arcus.ko
chmod ugo+rw /dev/arcus*

/reg/g/pcds/pyps/apps/ioc/latest/initIOC
