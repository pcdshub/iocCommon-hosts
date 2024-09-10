#!/bin/sh
echo Loading datadev module
insmod /reg/neh/home/weaver/aes-stream-drivers/data_dev/driver/datadev.ko.daq-tst-dev06 cfgSize=1114112 cfgRxCount=1024 cfgTxCount=4

sysctl -w fs.mqueue.msg_max=32

/reg/g/pcds/pyps/apps/ioc/latest/initIOC
