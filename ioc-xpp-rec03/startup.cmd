#!/bin/sh

source /reg/d/iocCommon/All/setup_gige.sh

if [ ! -e /dev/era0 -a $UID -eq 0 ]
then
        # Load EVR module on startup
        # Must be run as root
        #/usr/local/sbin/module_load
        /reg/g/pcds/package/epics/3.14/modules/ev2_driver/latest/driver/evr_load_module
fi

# Mount the appropriate EDT pdv directory
EDT_VER=5.5.1.6
if [ ! -e /opt/EDTpdv/version -o "`cat /opt/EDTpdv/version`" != "${EDT_VER}" ]
then
        if [ -d /reg/g/pcds/package/EDTpdv/R${EDT_VER}/`uname -r` ]; then
          mount --bind /reg/g/pcds/package/EDTpdv/R${EDT_VER}/`uname -r` /opt/ED
Tpdv
          mount --bind /reg/g/pcds/package/EDTpdv/R${EDT_VER}/pdv /opt/pdv
  else
    mount --bind /reg/g/pcds/package/EDTpdv/R${EDT_VER} /opt/EDTpdv
  fi
fi
if [ ! -e /dev/edt0 -a $UID -eq 0 ]
then
  # Install EDT driver on startup
  # Must be run as root
  /opt/EDTpdv/edtinit.sh start
fi

# Load driver for SLAC framegrabber
/usr/pgpcard/pgpcardG3

/reg/g/pcds/pyps/apps/ioc/latest/initIOC
