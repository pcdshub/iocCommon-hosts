#!/bin/sh

# Mount the appropriate EDT pdv directory
EDT_VER=5.5.1.6

if [ ! -e /opt/EDTpdv/version -o "`cat /opt/EDTpdv/version`" != "${EDT_VER}" ]
then
	if [ -d /reg/g/pcds/package/EDTpdv/R${EDT_VER}/`uname -r` ]; then
		mount --bind /reg/g/pcds/package/EDTpdv/R${EDT_VER}/`uname -r` /opt/EDTpdv
	else
		mount --bind /reg/g/pcds/package/EDTpdv/R${EDT_VER} /opt/EDTpdv
	fi
	# Major hack alert!
	# We can't create a link in /opt here as it's a ro filesystem, unlike on linuxRT
	# So, I went to pssrv100:/nfsexport/diskless/tst/x86_64-rhel5-ioc/root/opt and
	# manually created a soft link pdv -> /reg/g/pcds/package/EDTpdv/R5.5.1.6
	#ln -s $EDT_DRIVER/../pdv /opt/pdv
	#
	# Perhaps we could do something like this
	# mount --bind /reg/g/pcds/package/EDTpdv/R${EDT_VER} /opt/EDTpdv-top
	# ln -s /opt/EDTpdv-top/R${EDT_VER} /opt/EDTpdv
fi
if [ ! -e /dev/edt0 -a $UID -eq 0 ]
then
	# Install EDT driver on startup
	# Must be run as root
	/opt/EDTpdv/edtinit.sh start
fi

/reg/g/pcds/pyps/apps/ioc/latest/initIOC
