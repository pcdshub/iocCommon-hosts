#!/bin/sh

# Configure the network adapter to handle large BLD packets
ifconfig eth0 mtu 9000

EV2_DR_VER=1.0.2
if [ ! -e /dev/era0 -a $UID -eq 0 ]
then
    # Load EVR module on startup
    # Must be run as root
    /reg/g/pcds/epics/R3.14.12-0.4.0/modules/ev2_driver/$EV2_DR_VER/driver/evr_load_module
fi


# Mount the appropriate EDT pdv directory
EDT_VER=5.5.1.6
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

/reg/g/pcds/pyps/apps/ioc/latest/initIOC
