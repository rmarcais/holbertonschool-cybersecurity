#!/bin/bash
until (nc -zv localhost 80) > /dev/null 2>&1
do
    echo "Waiting..."
    sleep 1
done
echo "Service UP!"
