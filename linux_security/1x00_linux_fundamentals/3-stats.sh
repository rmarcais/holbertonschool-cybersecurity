#!/bin/bash
ls -l $1 | awk -F ' ' '{ print $3 }' | sort -r | uniq -c | head -1
