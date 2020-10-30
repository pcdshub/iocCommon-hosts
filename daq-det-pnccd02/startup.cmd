#!/bin/sh

# Block incoming channel access requests on the fez interface of this host
/sbin/iptables -A INPUT -i eth2 -p udp --destination-port 5064 -j DROP
/sbin/iptables -A INPUT -i eth2 -p udp --destination-port 5065 -j DROP

# chown???
chmod ugo+rw /dev/psf4ad* /dev/plxSEQ*

/reg/g/pcds/pyps/apps/ioc/latest/initIOC
