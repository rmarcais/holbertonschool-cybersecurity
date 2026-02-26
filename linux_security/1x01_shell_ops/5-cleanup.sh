#!/bin/bash
while read -r line; do
    id $line > /dev/null 2>&1
    if [ $? -eq 0 ]; then
	# TODO : Lock account
	echo "User $line locked"
    else
	echo "User $line not found"
    fi
done <$1
