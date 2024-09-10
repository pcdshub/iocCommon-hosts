
# Configure this host for gigE camera support
# Note: If you have gigE cameras on multiple network adapters,
# run this command for each one in addition to running setup_gige.sh.
# ip link set $IP_NAME mtu 9000
#export IP_NAME=enp65s0f0
#source /reg/d/iocCommon/All/setup_gige.sh $IP_NAME

# Setup a port for the Amphos IOC
ifconfig enp193s0f0 192.168.0.10 netmask 255.255.255.0 up

#export TPR_DRIVER=/reg/g/pcds/epics-dev/bhill/slaclab/pcieTprDriver-git
/cds/data/iocCommon/rhel7-x86_64/common/startup.cmd

