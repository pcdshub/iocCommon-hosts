#!/bin/sh

# Configure this host for gigE camera support
# (Also supports jumbo BLD packets for spectrometer)
source /reg/d/iocCommon/All/setup_gige.sh

# Enable core dumps
sysctl -w kernel.core_pattern=/tmp/%p.core
ulimit -c unlimited

# Mount the appropriate EDT pdv directory
EDT_VER=5.6.7.0
# Note: Changing the above EDT_VER definition is the only necessary change to select a new driver
# if you change the last line of this script from
# /reg/g/pcds/pyps/apps/ioc/latest/initIOC
# to
# source /reg/d/iocCommon/rhel7-x86_64/common/startup.cmd

# This is because the mount, insmod, and initIOC commands below are all handled
# by $IOC_COMMON/$T_A/common/startup.cmd and scripts it calls like kernel-modules.cmd.

# However, the following mount and insmod can safely be done here as the later scripts
# will detect that /dev/edt0 already exists.

if [ ! -e /opt/EDTpdv/version -o "`cat /opt/EDTpdv/version`" != "${EDT_VER}" ]
then
        mount --bind /reg/g/pcds/package/EDTpdv/R${EDT_VER}/`uname -r` /opt/EDTpdv
        mount --bind /reg/g/pcds/package/EDTpdv/R${EDT_VER}/pdv        /opt/pdv
fi
if [ ! -e /dev/edt0 -a $UID -eq 0 ]
then
	# Install EDT driver on startup
	# Must be run as root
	if [ ! -f /opt/EDTpdv/edtinit.sh ]; then
		echo ERROR: /opt/EDTpdv/edtinit.sh not found
	else
		/opt/EDTpdv/edtinit.sh start
	fi
fi

PGP_VER=1.0.0

#if [ ! -e "/dev/PgpCardG3_CLink_0" -a $UID -eq 0 ]
#then
#    # Install Pgp driver on startup
#    # Must be run as root
#    PGP_DRIVER=/reg/g/pcds/package/PgpCardG3/R${PGP_VER}/`uname -r`/
#    #PGP_DRIVER=/reg/g/pcds/package/pgpEdt/el5-x86_64/driver/
#    pushd ${PGP_DRIVER}
#    ./PgpCardG3_Load
#    popd
#fi

/reg/g/pcds/pyps/apps/ioc/latest/initIOC
