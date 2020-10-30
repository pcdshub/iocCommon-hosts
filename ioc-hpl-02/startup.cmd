#!/bin/sh

source /reg/d/iocCommon/All/setup_gige.sh

/sbin/modprobe perle-serial

/reg/g/pcds/pyps/apps/ioc/latest/initIOC
