#!/bin/bash

groups=("disk" "docker" "shadow")

awk -F: '{if ($3>=1000) print $1 }' $1 |
while read -r user; do
    for ug in $(id -nG $user 2>/dev/null); do
	for g in ${groups[@]}; do
	    if [ $ug = $g ]; then
		echo "$user:$g"
	    fi
	done
    done
done
