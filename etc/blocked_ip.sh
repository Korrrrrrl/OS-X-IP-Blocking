#!/bin/sh

# blocked_ip.sh
# Version 0.1.2
# Copyright (c) 2015 Karl Kernaghan
# Email - kkernaghan7@gmail.com

# This script creates a log based on the output of /etc/sshd-fwscan.sh and the output of
# /var/db/af/blacklist as used by the adaptive firewall.

# This script is called by /Library/LaunchDaemons/com.blocked_ip_list.plist
# and is run every 5 minuets printing it's output to /var/log/blocked_ip.log

echo "****************************" >> /var/log/blocked_ip.log

echo "$(date) - Blocked by ipfw:" >> /var/log/blocked_ip.log
ipfw list | grep deny >> /var/log/blocked_ip.log

echo "$(date) - Blocked by Adaptive Firewall:" >> /var/log/blocked_ip.log
less /var/db/af/blacklist >> /var/log/blocked_ip.log