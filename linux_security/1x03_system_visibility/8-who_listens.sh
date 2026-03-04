#!/bin/bash
lsof -n -i :$1 | awk 'N>1 {print $1}'
