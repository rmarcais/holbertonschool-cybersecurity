#!/bin/bash

mkdir -p $FW_CFG_DIR

if [ ! -f "$FW_CFG_FILE" ]; then
    touch "$FW_CFG_FILE"
fi

# Set firewall Policy
set_fw_policy() {
    grep -qxF "$1=$2" $3 || echo "$1=$2" >> $3
}

set_fw_policy "DEFAULT_INPUT" $DEFAULT_INPUT $FW_CFG_FILE
set_fw_policy "DEFAULT_OUTPUT" $DEFAULT_OUTPUT $FW_CFG_FILE
set_fw_policy "ALLOW_SSH" $ALLOW_SSH $FW_CFG_FILE
set_fw_policy "ALLOW_HTTP" $ALLOW_HTTP $FW_CFG_FILE
set_fw_policy "ALLOW_HTTPS" $ALLOW_HTTPS $FW_CFG_FILE

# Disable IP forwarding and ignore ICMP echo requests
sed -i -r 's/^net.ipv4.ip_forward=1$/net.ipv4.ip_forward=0/' $SYSCTL_CFG
sed -i -r 's/^net.ipv4.icmp_echo_ignore_all=0$/net.ipv4.icmp_echo_ignore_all=1/' $SYSCTL_CFG

sysctl -p
