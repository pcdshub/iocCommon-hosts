#!/bin/sh

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

/reg/g/pcds/pkg_mgr/release/procServ/2.8.0-1.0.0/linux-x86_64/bin/procServ --allow --ignore ^D --coresize 0 -c /tmp -l 51000 51001 /bin/sh --noediting -f

/reg/g/pcds/pyps/apps/ioc/latest/initIOC
