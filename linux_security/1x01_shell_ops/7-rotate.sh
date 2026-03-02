#!/bin/bash
if [ -d $1 ]
then
    mkdir -p $1/backups/
    for filename in $1/*.log; do
	if [ "$(wc -c $filename | cut -d' ' -f1)" -gt 1024 ]
	then
	    gzip $filename
	    mv $filename.gz $1/backups
	else
	    echo "Skipping small file: ${filename##*/}"
	fi
    done
else
    exit 1
fi
