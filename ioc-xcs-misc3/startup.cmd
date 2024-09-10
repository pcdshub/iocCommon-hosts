#!/bin/sh

source /reg/d/iocCommon/rhel7-x86_64/common/startup.cmd

source /reg/d/iocCommon/All/setup_gige.sh

/reg/g/pcds/pyps/apps/ioc/latest/initIOC
