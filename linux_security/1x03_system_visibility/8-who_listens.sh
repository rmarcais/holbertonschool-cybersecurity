#!/bin/bash
lsof -n -iTCP:$1 | awk 'N>1 {print $1}'
