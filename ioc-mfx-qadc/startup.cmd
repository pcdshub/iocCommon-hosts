#!/bin/sh
# Not this one. :-)
#echo Loading datadev module
#insmod /reg/neh/home/weaver/aes-stream-drivers/data_dev/driver/datadev.ko.daq-tst-dev06 cfgSize=1114112 cfgRxCount=1024 cfgTxCount=4

sysctl -w fs.mqueue.msg_max=32

export SLAC_AES_VER=v5.16.0
source /reg/d/iocCommon/rhel7-x86_64/common/startup.cmd
