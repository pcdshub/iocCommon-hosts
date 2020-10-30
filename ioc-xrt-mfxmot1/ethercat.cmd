#!/bin/bash

# A. Wallace
# 2016-05-24
# This loads the ethercat master kernel module for the mac address specified.
# It also starts the scanner.
# ===============================================================
# Define kernel module driver location
# ===============================================================

KERNEL_DRIVER_HOME=/reg/g/pcds/package/ethercat
ETHERCAT_DRIVER=$KERNEL_DRIVER_HOME/rhel5

# =================================
# Where to put the logfiles
# =================================

logRoot=/var/log
driverLogfile=$logRoot/ecatDrv.log
scannerLogfile=$logRoot/ecatScanner.log

## =========================================
## Load the kernel drivers
## =========================================

##need to make sure this one is specific to the mac address, should probably make this script more generic at some point
/sbin/ifconfig eth1 192.168.1.1

## =========================================
# The driver is loaded into the kernel in the next two lines, it needs to
# know what NIC to use for the master, so you must pass it the MAC of the
# interface you will use. If this succeeds it will create a /dev/EtherCAT*
# handle for the ethercat master. Defaults to EtherCAT0
# If you don't see this handle, something has gone wrong in loading the
# kernel. Check to make sure your architecture matches the driver you're
# loading, eg. rhel5 vs rhel6, x86 or x86_64
## =========================================

/sbin/insmod $ETHERCAT_DRIVER/master/ec_master.ko main_devices=00:25:90:65:1B:DD
/sbin/insmod $ETHERCAT_DRIVER/devices/ec_generic.ko


## =========================================
# Bringing up the master
## =========================================

/sbin/ifconfig eth1 up

# ==========================================
# Adding the ethercat cli to the environment
# ==========================================
ln -s $ETHERCAT_DRIVER/tool/ethercat /sbin/ethercat
# ==============================================================
# Waiting a bit to make sure the ethercat device handle is ready for the scanner
# ==============================================================
sleepTime=30
sleepLimit=300
while [ ! -e /dev/EtherCAT0 ]
do
	sleep $sleepTime
	let "sleepTime+=10"
	if [ "$sleepTime" -gt "$sleepLimit" ]
	then
		echo "Failed to get handle in time" >> $driverLogfile
		exit 1
	fi
done



## ==================================
# Make sure the permissions for the handles are correct
## ==================================
chmod o+rw /dev/EtherCAT* >> $driverLogfile


## ==================================
## Start the Scanner Process Here:
## NOTE: The release here must match your IOC release! 
## The scanner.xml file is rebuilt everytime you build the IOC and must
## match what's actually on the ethercat network.
## ==================================
# The $scanner variable should point at the etc/ of the release you are going to run
# That etc/ should contain a startScanner.sh script and the scanner.xml which is built
# by the IOC build process.
export SCANNER=/reg/g/pcds/package/epics/3.14/ioc/mfx/attenuator/R0.1.3/etc

pushd $SCANNER

source startScanner.sh


