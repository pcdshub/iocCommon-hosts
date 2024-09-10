#!/bin/sh

# Make QMINI happy (?)
udevadm control --reload-rules
udevadm trigger --subsystem-match=usb
udevadm trigger --subsystem-match=tty

/reg/g/pcds/pyps/apps/ioc/latest/initIOC
