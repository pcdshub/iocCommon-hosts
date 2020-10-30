#!/bin/sh
source /reg/d/iocCommon/All/setup_gige.sh
ifconfig eth0 mtu 9000

/reg/g/pcds/pyps/apps/ioc/latest/initIOC
