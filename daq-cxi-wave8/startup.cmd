#!/bin/sh

/usr/pgpcard/pgpcard
/usr/pgpcard/pgpcardG3

# /sbin/modprobe perle-serial
/reg/g/pcds/package/epics/3.14/modules/ev2_driver/latest/driver/evr_load_module

# Configure the network adapter to handle large BLD packets
ifconfig eth0 mtu 9000

/reg/g/pcds/pyps/apps/ioc/latest/initIOC
