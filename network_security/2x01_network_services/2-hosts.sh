#!/bin/bash
cat /etc/hosts | grep -E "^[[:digit:]].*localhost$" | awk '{print $1}'
