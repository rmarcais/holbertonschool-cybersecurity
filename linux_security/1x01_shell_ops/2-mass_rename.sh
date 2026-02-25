#!/bin/bash
find $1 -name "*.log" | sed 'p;s/\.log/\.log.old/' | xargs -n2 mv
