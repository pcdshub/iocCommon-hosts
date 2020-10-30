#!/bin/sh

# Configure this host for gigE camera support
# (Also supports jumbo BLD packets for spectrometer)
source /reg/d/iocCommon/All/setup_gige.sh

# Mount the appropriate EDT pdv directory
EDT_VER=5.5.1.6
if [ ! -e /opt/EDTpdv/version -o "`cat /opt/EDTpdv/version`" != "${EDT_VER}" ]
then
        mount --bind /reg/g/pcds/package/EDTpdv/R${EDT_VER}/`uname -r` /opt/EDTpdv
        mount --bind /reg/g/pcds/package/EDTpdv/R${EDT_VER}/pdv        /opt/pdv
fi
if [ ! -e /dev/edt0 -a $UID -eq 0 ]
then
	# Install EDT driver on startup
	# Must be run as root
	/opt/EDTpdv/pcds_edtinit start
fi

PGP_VER=1.0.0

if [ ! -e "/dev/PgpCardG3_CLink_0" -a $UID -eq 0 ]
then
    # Install Pgp driver on startup
    # Must be run as root
    PGP_DRIVER=/reg/g/pcds/package/PgpCardG3/R${PGP_VER}/`uname -r`/
    pushd ${PGP_DRIVER}
    ./PgpCardG3_Load
    popd
fi

/reg/d/iocCommon/hosts/ioc-tst-12/setup_flir.cmd

/reg/g/pcds/pyps/apps/ioc/latest/initIOC
