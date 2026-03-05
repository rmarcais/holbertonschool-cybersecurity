#!/bin/bash

if [ ! -z "$1" ] && [ -f "$1" ]; then
    source "$1"
else
    echo "Error: bad config file"
    echo "Usage: $0 <config_file>"
    exit 1
fi

: "${SERVICES:?Variable SERVICES not defined}"
: "${FILES_TO_WATCH:?Variable FILES_TO_WATCH not defined}"
