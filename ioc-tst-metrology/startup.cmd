#!/bin/sh

# Block incoming channel access requests on the ics interface of this host
/sbin/iptables -A INPUT -i eth2 -p udp --destination-port 5064 -j DROP
/sbin/iptables -A INPUT -i eth2 -p udp --destination-port 5065 -j DROP

/reg/g/pcds/pyps/apps/ioc/latest/initIOC
# Start caRepeater
$RUNUSER "$PROCSERV --logfile $IOC_DATA/$IOC_HOST/iocInfo/caRepeater.log --name caRepeater 30000 $CA_BIN/caRepeater"
