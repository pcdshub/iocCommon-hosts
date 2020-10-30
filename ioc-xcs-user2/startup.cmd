#!/bin/sh

source /reg/d/iocCommon/All/setup_gige.sh

if [ ! -e /dev/era0 -a $UID -eq 0 ]
then
        # Load EVR module on startup
        # Must be run as root
        #/usr/local/sbin/module_load
        /reg/g/pcds/package/epics/3.14/modules/ev2_driver/R1.0.1/driver/evr_load_module
fi

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

# This node has some dead file descriptor that causes libusb to have an error - remove it I guess...
if [ -e /dev/bus/usb/002/002 ]; then
  rm /dev/bus/usb/002/002
fi
# The USD4 needs this writable! Kill old ones that might be owned by others
rm -f /dev/shm/sem.Usb4-*

# Load the USB driver (ftdi)
/sbin/modprobe ftdi_sio
# Give it time to be created, then fix permissions on USB device
echo "Loaded modules:"
/sbin/lsmod | grep ftdi_sio
sleep 1
ls -l /dev | grep USB

/reg/g/pcds/pyps/apps/ioc/latest/initIOC
