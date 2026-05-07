#!/bin/bash
IFS=. read ip1 ip2 ip3 ip4 <<<"$1" ; IFS=. read m1 m2 m3 m4 <<<"$2" ; printf "%d.%d.%d.%d" $((ip1 | ((~m1) & 255))) $((ip2 | ((~m2) & 255))) $((ip3 | ((~m3) & 255))) $((ip4 | ((~m4) & 255)))
