#!/bin/sh

# Configure this host for gigE camera support
# (Also supports jumbo BLD packets for spectrometer)
source /reg/d/iocCommon/All/setup_gige.sh

##
## Add extra debugging for the uEye driver to the syslog.
##
#mount --bind ~mcbrowne/src/uEye/rsyslog.conf /etc/rsyslog.conf
#service rsyslog stop
#service rsyslog start
##
## Until Omar fixes the udev rules!
##
#mount --bind ~mcbrowne/src/uEye/rules.d /etc/udev/rules.d
#udevadm control --reload-rules
#
##
## Start the uEye driver and add debugging for it to the syslog.
##
#/reg/g/pcds/package/external/ueye-4.91.1.0/setup.sh
#
#sleep 15
#udevadm trigger --subsystem-match=usb

#
# Let slip the dogs of war.
#
/reg/g/pcds/pyps/apps/ioc/latest/initIOC
