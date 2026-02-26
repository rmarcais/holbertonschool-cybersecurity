#!/bin/bash
until [] # TODO : add the command to check if port 80 is listening on localhost
do
    echo "Waiting..."
    sleep 1
done
echo "Service UP!"
