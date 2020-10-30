#!/bin/sh

## DAQ setup
/sbin/modprobe pgpcard
/usr/pgpcard/pgpcard
/sbin/ifconfig eth1 172.21.24.65 netmask 255.255.255.0 mtu 9000 up
/reg/g/pcds/dist/pds/tools/procmgr/procmgrd.init start

/reg/g/pcds/pyps/apps/ioc/latest/initIOC
