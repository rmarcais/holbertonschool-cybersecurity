#!/bin/bash
tshark -r "$1" -Y "dns" -T fields -e dns.qry.name | awk 'length($0) > 50'
