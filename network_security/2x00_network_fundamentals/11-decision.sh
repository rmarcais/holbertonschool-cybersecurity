#!/bin/bash
ip route get $1 | grep ' via ' | wc -l | awk '{ if  ($1 == 0) print "LOCAL"; else print "REMOTE"}'
