#!/bin/bash
until (echo > /dev/tcp/localhost/80) > /dev/null 2>&1
do
    echo "Waiting..."
    sleep 1
done
echo "Service UP!"
