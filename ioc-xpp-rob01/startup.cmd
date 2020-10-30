#!/bin/sh

# Block incoming channel access requests on the ics interface of this host
/sbin/iptables -A INPUT -i eth1 -p udp --destination-port 5064 -j DROP
/sbin/iptables -A INPUT -i eth1 -p udp --destination-port 5065 -j DROP

/reg/g/pcds/pyps/apps/ioc/latest/initIOC
