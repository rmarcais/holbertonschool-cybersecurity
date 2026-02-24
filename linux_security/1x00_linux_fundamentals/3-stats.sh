#!/bin/bash
ls -l $1 | cut -d " " -f 3 | uniq -c | sort -r | head -1
