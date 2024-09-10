#!/bin/sh

/reg/g/pcds/pyps/apps/ioc/latest/initIOC

# Configure this host for gigE camera support
# (Also supports jumbo BLD packets for spectromet
source /reg/d/iocCommon/All/setup_gige.sh
