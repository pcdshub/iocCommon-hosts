#!/bin/sh

#/sbin/modprobe pgpcard
#/usr/pgpcard/pgpcard
#/usr/pgpcard/pgpcardG3

# Load the pgpcard driver
/reg/g/pcds/dist/pds/boot/pgp_load_module

/reg/g/pcds/pyps/apps/ioc/latest/initIOC
