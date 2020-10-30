#!/bin/sh

## DAQ setup
/sbin/modprobe pgpcard
/usr/pgpcard/pgpcard
# Block incoming channel access requests on the fez interface of this host
/sbin/iptables -A INPUT -i eth1 -p udp --destination-port 5064 -j DROP
/sbin/iptables -A INPUT -i eth1 -p udp --destination-port 5065 -j DROP
## bmmon, not wave8! /sbin/ifconfig eth1 172.21.24.65 netmask 255.255.255.0 mtu 9000 up
/reg/g/pcds/dist/pds/tools/procmgr/procmgrd.init start
/reg/g/pcds/pyps/apps/ioc/latest/initIOC
