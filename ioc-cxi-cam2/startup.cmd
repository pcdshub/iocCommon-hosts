#!/bin/sh

# Configure this host for gigE camera support
# (Also supports jumbo BLD packets for spectromet
source /reg/d/iocCommon/All/setup_gige.sh

# load the latest evr driver
#/cds/group/pcds/epics/modules/ev2_driver/latest/driver/evr_load_module

# Increase usbfs_memory_mb from default needed for usb3 cameras (e.g. Alvium, Zyla)
echo "1024" > /sys/module/usbcore/parameters/usbfs_memory_mb

# Block responding to epics discovery requests on the machine's FEZ interface
/cds/group/pcds/dist/pds/boot/epics-fez-block.sh

# set cpufreq governor to performance
for f in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
  echo "performance" > $f
done

/reg/g/pcds/pyps/apps/ioc/latest/initIOC
