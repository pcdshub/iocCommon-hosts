#!/bin/sh

#/reg/g/pcds/pkg_mgr/release/procServ/2.8.0-1.0.0/linux-x86_64/bin/procServ --name mcb-cheat --allow --coresize 0 42424 /bin/tcsh

ecatModule=/reg/g/pcds/package/epics/3.14-dev/modules/ethercat/current
userIO_IOC=/reg/g/pcds/package/epics/3.14/ioc/mfx/userIO/R0.2.1

bash -x $ecatModule/etc/scripts/loadEcatModules.cmd eth1 2>&1 | tee -a /var/log/ecat-startup.log

/reg/g/pcds/package/epics/3.14-dev/modules/ethercat/current/etc/scripts/startScanner.cmd $userIO_IOC

/reg/g/pcds/pyps/apps/ioc/latest/initIOC
