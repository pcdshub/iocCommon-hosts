#!/bin/sh

/usr/pgpcard/pgpcard
/usr/pgpcard/pgpcardG3

# /sbin/modprobe perle-serial
/reg/g/pcds/package/epics/3.14/modules/ev2_driver/R1.0.2/driver/evr_load_module

# Mount the appropriate EDT pdv directory
#EDT_VER=4.2.1.7
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

# Setup the UIO driver for the Acromag card.
if [ ! -f /sys/bus/pci/drivers/uio_pci_generic/new_id ]; then
    modprobe uio
    insmod /lib/modules/`uname -r`/kernel/daq/uio_pci_generic.ko
fi

#this binds the uio_pci_generic driver to the Acromag carrier
echo "16d5 5901" > /sys/bus/pci/drivers/uio_pci_generic/new_id
#wait a bit for things to happen
sleep 2
chmod 666 /dev/uio0
chmod 666 /sys/class/uio/uio0/device/config
chmod 666 /sys/class/uio/uio0/device/resource2

/reg/g/pcds/pyps/apps/ioc/latest/initIOC
