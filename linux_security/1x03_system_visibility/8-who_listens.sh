#!/bin/bash
lsof -nP -iTCP:$1 -sTCP:LISTEN | awk 'N>1 {print $1}'
