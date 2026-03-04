#!/bin/bash
lsof -P -n -iTCP:$1 -sTCP:LISTEN | awk 'N==2 {print $1}'
