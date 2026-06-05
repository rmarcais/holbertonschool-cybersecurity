#!/bin/bash
tshark -r "$1" -Y "ip.addr == 172.16.42.66" -T fields -e frame.time | awk '{ if(NR==1) first=$0; last=$0 } END{print first; if(NR>1) print last}'
