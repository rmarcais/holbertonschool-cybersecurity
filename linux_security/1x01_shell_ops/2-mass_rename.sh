#!/bin/bash
find $1 -maxdepth 1 -name "*.log" -print0 | sed 'p;s/\.log/\.log.old/' | xargs -0 -n2 mv
