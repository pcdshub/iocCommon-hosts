#!/bin/sh

# Configure this host for gigE camera support
source /reg/d/iocCommon/All/setup_gige.sh enp1s0f0

/reg/g/pcds/pyps/apps/ioc/latest/initIOC
