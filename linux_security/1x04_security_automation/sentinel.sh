#!/bin/bash
CONFIG_FILE="./sentinel.conf"

if [ ! -z "$CONFIG_FILE" ] && [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
else
    echo "Error: config file is missing"
    exit 1
fi

: "${SERVICES:?Variable SERVICES not defined}"
: "${FILES_TO_WATCH:?Variable FILES_TO_WATCH not defined}"
