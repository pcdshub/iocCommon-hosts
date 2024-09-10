#!/bin/sh

# Configure this host for gigE camera support
# (Also supports jumbo BLD packets for spectromet
source /reg/d/iocCommon/All/setup_gige.sh

# Mount the appropriate EDT pdv directory
EDT_VER=5.5.1.6
if [ ! -e /opt/EDTpdv/version -o "`cat /opt/EDTpdv/version`" != "${EDT_VER}" ]; then
     mount --bind /reg/g/pcds/package/EDTpdv/R${EDT_VER}/`uname -r` /opt/EDTpdv
     mount --bind /reg/g/pcds/package/EDTpdv/R${EDT_VER}/pdv        /opt/pdv
fi
if [ ! -e /dev/edt0 -a $UID -eq 0 ]; then
    # Install EDT driver on startup
    # Must be run as root
    /opt/EDTpdv/edtinit.sh start
fi
/reg/g/pcds/pyps/apps/ioc/latest/initIOC
