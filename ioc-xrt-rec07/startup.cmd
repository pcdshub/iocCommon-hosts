#!/bin/sh

# Configure the network adapter to handle large BLD packets
ifconfig eth0 mtu 9000

EV2_DR_VER=latest
if [ ! -e /dev/era0 -a $UID -eq 0 ]
then
    # Load EVR module on startup
    # Must be run as root
    /reg/g/pcds/epics/R3.14.12-0.4.0/modules/ev2_driver/$EV2_DR_VER/driver/evr_load_module
fi


# Mount the appropriate EDT pdv directory
#EDT_VER=5.5.5.4
EDT_VER=5.5.1.6
#EDT_VER=5.6.7.0
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

# The USD4 needs this writable! Kill old ones that might be owned by others
rm -f /dev/shm/sem.Usb4-*

# Fixes so unicast PV discovery works with multiple IOCs on a machine
/cds/group/pcds/dist/pds/boot/epics-ca-unicast-fix.sh

/reg/g/pcds/pyps/apps/ioc/latest/initIOC
