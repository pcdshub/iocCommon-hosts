#!/bin/sh

/sbin/modprobe pgpcard
/usr/pgpcard/pgpcard
/sbin/ifconfig eth1 172.21.46.118 netmask 255.255.255.0
/bin/mount -t cifs -o rw,username=LCLS-PC84615,password=lcls-usr84615,dir_mode=0777,file_mode=0777 //172.21.46.106/RackShare /var/RackShare

/reg/g/pcds/pyps/apps/ioc/latest/initIOC
