#!/bin/bash

#this will display the hostname of the system
host_name=$(hostname)
domain_name=$(hostname)

# This will show the details of the op system
operatingS_name=$(lsb_release -d -s)

#for showing the ip address
ip_address=$(hostname -I)

#for the free space.
free_space=$(df -h | grep -w "/" | awk '{print $4}')

#  for print out the result
cat <<EOF
Report for: $host_name
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
domain_name: $domain_name
Operating System name and version: $operatingS_name
IP Address: $ip_address
Root Filesystem Free Space: $free_space
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
EOF
