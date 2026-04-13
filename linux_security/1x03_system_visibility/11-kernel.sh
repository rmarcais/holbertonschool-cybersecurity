#!/bin/bash

FILE_1="/var/log/kern.log"
FILE_2="/var/log/messages"

if [ -f $FILE_1 ]; then
    grep $1 $FILE_1
else
    echo "$FILE_1 doesn't exist"
fi

if [ -f $FILE_2 ]; then
    grep $1 $FILE_2
else
    echo "$FILE_2 doesn't exist"
fi
