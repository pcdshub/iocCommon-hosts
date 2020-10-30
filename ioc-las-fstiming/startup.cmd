#!/bin/sh


/reg/g/pcds/pyps/apps/ioc/latest/initIOC

source /reg/d/iocCommon/All/las_env.sh
# Launch the fstiming control scripts
# MCB - These should be added to iocmanager.  This has been done for CXI.
# Don't enable these for now, as they fail when run as lasioc
#$RUNUSER "/reg/d/iocCommon/launch/fstiming.sh AMO"
$RUNUSER "/reg/d/iocCommon/launch/fstiming.sh SXR"
$RUNUSER "/reg/d/iocCommon/launch/fstiming.sh XPP"
# $RUNUSER "/reg/d/iocCommon/launch/fstiming.sh XCS"
# $RUNUSER "/reg/d/iocCommon/launch/fstiming.sh CXI"
$RUNUSER "/reg/d/iocCommon/launch/fstiming.sh MEC"

$RUNUSER "/reg/g/iocCommon/launch/fstiming-tt.sh XPP"
