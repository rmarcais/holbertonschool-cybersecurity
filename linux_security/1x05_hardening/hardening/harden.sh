#!/bin/bash

######################
# Checks config file
######################
CONFIG_FILE="./config/harden.cfg"

if [ ! -z "$CONFIG_FILE" ] && [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
else
    echo "Error: config file is missing"
    exit 1
fi

####################
# Launches scripts
####################

source $NETWORK_SCRIPT
