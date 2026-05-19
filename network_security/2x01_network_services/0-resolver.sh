#!/bin/bash
cat /etc/resolv.conf | grep "nameserver" | head -1 | awk -F' ' '{print $2}'
