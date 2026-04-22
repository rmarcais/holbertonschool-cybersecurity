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

###############################
# Checks current privilieges
###############################

if [ $EUID -ne 0 ]; then
    echo "Error: this script must be executed as root"
    exit 1
fi

####################
# Launches scripts
####################

source $NETWORK_SCRIPT
source $SSH_SCRIPT
source $IDENTITY_SCRIPT
source $SYSTEM_SCRIPT
