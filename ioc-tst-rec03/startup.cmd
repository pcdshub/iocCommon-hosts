#!/bin/sh

export PSPKG_ROOT=/reg/g/pcds/pkg_mgr

# Configure this host for gigE camera support
# (Also supports jumbo BLD packets for spectrometer)
source /reg/d/iocCommon/All/setup_gige.sh

# Mount the appropriate EDT pdv directory
#EDT_VER=5.5.1.6
EDT_VER=5.5.8.2
if [ ! -e /opt/EDTpdv/version -o "`cat /opt/EDTpdv/version`" != "${EDT_VER}" ]
then
    if [ -d /reg/g/pcds/package/EDTpdv/R${EDT_VER}/`uname -r` -a    \
         -d /reg/g/pcds/package/EDTpdv/R${EDT_VER}/pdv ]; then
        mount --bind /reg/g/pcds/package/EDTpdv/R${EDT_VER}/`uname -r` /opt/EDTpdv
        mount --bind /reg/g/pcds/package/EDTpdv/R${EDT_VER}/pdv /opt/pdv
    else
        mount --bind /reg/g/pcds/package/EDTpdv/R${EDT_VER} /opt/EDTpdv
    fi
fi
if [ ! -e /dev/edt0 -a $UID -eq 0 ]
then
    # Install EDT driver on startup
    # Must be run as root
    if [ -e /opt/EDTpdv/pcds_edtinit ]
    then
        /opt/EDTpdv/pcds_edtinit start
    else
        /opt/EDTpdv/edtinit.sh start
    fi
fi

# Check for MRF EVR boards w/ PLX 9030 bridge
lspci_mrf_evr=`lspci -d 10b5:9030 -n`
# Also check for SLAC EVR
lspci_slac_evr=`lspci -d 1a4a:2010 -n`
EV2_DRIVER=$EPICS_SITE_TOP/R3.14.12-0.4.0/modules/ev2_driver/latest/
if [ "$lspci_mrf_evr" != "" -o "$lspci_slac_evr" != "" ]; then
	if [ -n "$EV2_DRIVER" -a -d $EV2_DRIVER/ ]; then
		echo Installing EVENT2 driver: $EV2_DRIVER
		$EV2_DRIVER/driver/evr_load_module
		if [ -e /dev/era0 ];
		then
			chmod a+rw /dev/er*
		else
			/sbin/rmmod evr_device
		fi
		if [ -e /dev/ega0 ];
		then
			chmod a+rw /dev/eg*
		else
			/sbin/rmmod pci_mrfevg
		fi
	else
		echo event2 driver dir not found: $EV2_DRIVER
	fi
else
	echo EVR not found.
fi

/reg/g/pcds/pyps/apps/ioc/latest/initIOC

# Setup our path, so we can find procServ and procmgrd!
#if [ -z "$PSPKG_ROOT" ]; then
#   export PSPKG_ROOT=/reg/g/pcds/pkg_mgr
#fi
#export PSPKG_RELEASE=controls-basic-0.0.3
#source $PSPKG_ROOT/etc/set_env.sh
#
#export SCRIPTROOT=/reg/neh/home/bhill/wa2/package/ioc
#export PATH=${SCRIPTROOT}:$PATH
#source $SCRIPTROOT/initIOC.hutch
