#!/bin/bash
lsof -P -n -iTCP:$1 -sTCP:LISTEN | awk 'NR==2 {print $1}'
