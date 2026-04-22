#!/bin/bash

# Updates
apt-get update
apt-get upgrade -y

# Uninstalls bloatwares
apt-get remove -y "${BLOATWARES[@]}"

# Installs tools
apt-get install -y "${TOOLS_TO_INSTALL[@]}"
