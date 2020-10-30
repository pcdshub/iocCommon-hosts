#!/bin/sh

# Configure this host for gigE camera support
# (Also supports jumbo BLD packets for spectrometer)
source /reg/d/iocCommon/All/setup_gige.sh

# MCB - I should bug Omar about this, but for now...
mount --bind ~mcbrowne/src/uEye/rules.d /etc/udev/rules.d

# QADC driver
~mcbrowne/src/hsd/startup

# Make QMINI happy (?)
udevadm control --reload-rules
udevadm trigger --subsystem-match=usb
udevadm trigger --subsystem-match=tty

# PGPcard stuff!
/sbin/modprobe pgpcard
/usr/pgpcard/pgpcard
/usr/pgpcard/pgpcardG3

/reg/g/pcds/dist/pds/boot/datadev_load_module

/reg/g/pcds/pyps/apps/ioc/latest/initIOC
