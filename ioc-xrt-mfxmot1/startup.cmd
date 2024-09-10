#!/bin/sh


bash -x /reg/d/iocCommon/hosts/ioc-xrt-mfxmot1/ethercat.cmd 

# Mount the appropriate EDT pdv directory
EDT_VER=5.5.1.6
if [ ! -e /opt/EDTpdv/version -o "`cat /opt/EDTpdv/version`" != "${EDT_VER}" ]
then
        if [ -d /reg/g/pcds/package/EDTpdv/R${EDT_VER}/`uname -r` ]; then
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
  /opt/EDTpdv/edtinit.sh start
fi

#/reg/g/pcds/pkg_mgr/release/procServ/2.8.0-1.0.0/linux-x86_64/bin/procServ --name mcb-cheat --allow --coresize 0 42424 /bin/tcsh

/reg/g/pcds/pyps/apps/ioc/latest/initIOC

