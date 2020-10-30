#!/bin/sh

ecatModule=/reg/g/pcds/package/epics/3.14-dev/modules/ethercat/current
userIO_IOC = /reg/g/pcds/package/epics/3.14/ioc/mfx/userIO/R0.2.0

bash -x $ecatModule/etc/scripts/loadEcatModules.cmd eth1 2>&1 | tee -a /var/log/ecat-startup.log

/reg/g/pcds/package/epics/3.14-dev/modules/ethercat/current/etc/startScanner.sh $userIO_IOC

/reg/g/pcds/pyps/apps/ioc/latest/initIOC
