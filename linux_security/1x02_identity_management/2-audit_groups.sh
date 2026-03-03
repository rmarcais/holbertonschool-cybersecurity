#!/bin/bash
awk -F':' '{if ($3 >= 1000) print $1 }' $1 |
while read -r user; do
    id -nG $user 2>/dev/null |
    tr ' ' '\n' |
    grep -Ex '^(disk|docker|shadow)$' |
    sed "s/^/$user:/"
done
