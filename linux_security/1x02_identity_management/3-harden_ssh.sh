#!/bin/bash
set -e

sed -i -r 's/^PermitRootLogin yes/PermitRootLogin no/' $1
sed -i -r 's/^PasswordAuthentication yes/PasswordAuthentication no/' $1
sed -i -r 's/^PubkeyAuthentication no/PubkeyAuthentication yes/' $1

sshd -t > /dev/null 2>&1
/etc/init.d/ssh reload > /dev/null 2>&1
