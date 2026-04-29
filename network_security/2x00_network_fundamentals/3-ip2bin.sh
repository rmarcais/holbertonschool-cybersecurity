#!/bin/bash
echo "$1" | awk -F'.' '{
	for(i=1; i<=4; i++) {
		cmd="echo \"obase=2;"$i"\" | bc"
		cmd | getline binary
		close(cmd)
		printf "%08d%s", binary, (i<4?".":"\n")
	}
}'
