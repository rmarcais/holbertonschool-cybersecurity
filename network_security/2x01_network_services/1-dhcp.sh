#!/bin/bash
nmcli -f DHCP4 device show | grep "dhcp_server_identifier =" | awk -F' = ' '{print $2}'
