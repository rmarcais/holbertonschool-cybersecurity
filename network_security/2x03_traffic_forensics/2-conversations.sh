#!/bin/bash
tshark -r $1 -q -z conv,tcp | tail -n +6 | head -n -1 | awk '{ print $1, $2, $3, $11}'
