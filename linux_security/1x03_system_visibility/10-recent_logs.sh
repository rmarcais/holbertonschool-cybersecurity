#!/bin/bash
awk -v date="$(date --date='30 minutes ago' '+%b %d %H:%M')" '$0 > date' $1 | grep sshd
