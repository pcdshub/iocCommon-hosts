#!/bin/sh

# Mount the appropriate EDT pdv directory
EDT_VER=5.4.5.1
if [ ! -e /opt/EDTpdv/version -o "`cat /opt/EDTpdv/version`" != "${EDT_VER}" ]
then
        mount --bind /reg/g/pcds/package/EDTpdv/R${EDT_VER} /opt/EDTpdv
fi
if [ ! -e /dev/edt0 -a $UID -eq 0 ]
then
	# Install EDT driver on startup
	# Must be run as root
	/opt/EDTpdv/pcds_edtinit start
fi

/reg/g/pcds/pyps/apps/ioc/latest/initIOC
