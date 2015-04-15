#!/bin/bash

# Installer script for OS X blocked IP logging
# Version 0.1.1
# Copyright (c) 2015 Karl Kernaghan
# Email - kkernaghan7@gmail.com
#
# To install run sudo ./install.sh
#
# System changes:
#
# blocked_ip.sh is placed in /etc
# This script is called by /Library/LaunchDaemons/com.blocked_ip_list.plist
# every 5 minuets. This script gathers information from adaptive firewall
# and places it in /var/log/blocked_ip.log
#
# log_fix_blocked_ip.pl is added to /Users/<user>/bin
# If ~/bin does not exist it will be created.
# This script is to be used after every reboot for the time being as I 
# have not found out why things don't work right after a reboot.
#
# com.ssh_block.script.plist is added to /Library/LaunchDaemons.
# This is the .plist files that allows this script to run when required.
#
# The following line is added to /etc/newsyslog.conf
#
# /var/log/blocked_ip.log                640  7     *    @T00  JN
#
# This entry allows the blocked_ip.log to be created in /var/log in the
# same fasion as the system.log. This log is set to rotate at 12:00AM 
# everyday and saves logs for 7 days.
#
# This install script will also run log_fix_blocked_ip.pl to get you started without 
# a reboot. For now after each reboot you will need to run ~/bin/log_fix_blocked_ip.pl
# if you've decided to find a way to run this during boot, please email me
# and let me know what you did. Thanks.

echo "Creating ~/bin if not already there"
mkdir bin ~/bin
echo "Copying log_fix_blocked_ip.pl to ~/bin"
cp bin/log_fix_blocked_ip.pl ~/bin
sleep 3
echo "Setting permissions"
chmod +x ~/bin/log_fix_blocked_ip.pl
sleep 3

echo "Adding /var/log/blocked_ip.log                640  7     *    @T00  JN to /etc/newsyslog.conf"
sleep 3
echo "/var/log/blocked_ip.log                640  7     *    @T00  JN" >> /etc/newsyslog.conf
sleep 3

echo "Copying blocked_ip.sh to /etc"
cp etc/blocked_ip.sh /etc
sleep 3

echo "Setting permissions"
chmod +x /etc/blocked_ip.sh
sleep 3

echo "Copying com.blocked_ip_list.plist to /Library/LaunchDaemons"
cp Library/LaunchDaemons/com.blocked_ip_list.plist /Library/LaunchDaemons
sleep 3

echo "Running log_fix_blocked_ip.pl"
~/bin/log_fix_blocked_ip.pl
sleep 5

echo "All files are installed now. You should now see blocked_ip.log in /var/log/"
echo "Please check the log in about 5 - 10 minuets and you should see data."
