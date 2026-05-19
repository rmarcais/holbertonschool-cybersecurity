#!/bin/bash
cat /etc/hosts | grep -E "^[[:digit:]].*localhost$" | awk -F' ' '{printf "%s", $1}'
