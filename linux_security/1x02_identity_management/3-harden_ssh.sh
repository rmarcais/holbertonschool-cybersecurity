#!/bin/bash
set -e

sed -i -r 's/^(PermitRootLogin|PasswordAuthentication)([[:space:]]+)yes/\1\2no/' $1
sed -i -r 's/^(PubkeyAuthentication)([[:space:]]+)no/\1\2yes/' $1

sshd -t > /dev/null 2>&1
/etc/init.d/ssh reload > /dev/null 2>&1
