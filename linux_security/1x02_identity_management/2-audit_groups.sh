#!/bin/bash

groups="disk docker shadow"

awk -F: '{if ($3>=1000) print $1 }' $1 |
while read -r user; do
    user_groups=$(id -nG "$user" 2>/dev/null)
    for g in $groups; do
	echo $user_groups | grep -qw $g && echo "$user:$g"
    done
done
