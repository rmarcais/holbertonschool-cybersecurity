#!/bin/bash
sudo awk -F':' '{if ($2 ~ /^\$1\$/) print $1}' /etc/shadow
