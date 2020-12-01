#!/bin/sh

# QADC driver
~mcbrowne/src/hsd/startup
/reg/d/iocCommon/hosts/ioc-mec-qadc/qadc.setup

/reg/g/pcds/pyps/apps/ioc/latest/initIOC
