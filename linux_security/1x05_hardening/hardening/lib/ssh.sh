#!/bin/bash

set -e

# Disables password auth, and enable public key auth
sed -ir 's/^PermitRootLogin yes/PermitRootLogin no/' $SSHD_CONFIG
sed -ir 's/^PasswordAuthentication yes/PasswordAuthentication no/' $SSHD_CONFIG

# Set PermitRootLogin to no
sed -ir 's/^PubkeyAuthentication no/PubkeyAuthentication yes/' $SSHD_CONFIG

# Tests and reloads
sshd -t > /dev/null 2>&1
$RELOAD_SSHD_COMMAND > /dev/null 2>&1
