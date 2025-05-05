#!/bin/sh

if [ ! -f /sys/bus/pci/drivers/uio_pci_generic/new_id ]; then
    #modprobe uio
    #insmod /lib/modules/`uname -r`/kernel/daq/uio_pci_generic.ko
    modprobe uio_pci_generic
fi

#this binds the uio_pci_generic driver to the Acromag carrier
echo "16d5 5901" > /sys/bus/pci/drivers/uio_pci_generic/new_id
#wait a bit for things to happen
sleep 2
chmod 666 /dev/uio0
chmod 666 /sys/class/uio/uio0/device/config
chmod 666 /sys/class/uio/uio0/device/resource2

# fix that allows unicast addresses to be used when there is more than one IOC on a machine
/cds/group/pcds/dist/pds/boot/epics-ca-unicast-fix.sh

/reg/g/pcds/pyps/apps/ioc/latest/initIOC
