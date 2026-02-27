#!/bin/bash
sed -i -r 's/^(PermitRootLogin|PasswordAuthentication)([[:space:]]+)yes/\1\2no/' /etc/ssh/sshd_config
sed -i -r 's/^(PubkeyAuthentication)([[:space:]]+)no/\1\2yes/' /etc/ssh/sshd_config

sshd -t > /dev/null 2>&1
if [ $? -eq 0 ]; then
    /etc/init.d/ssh restart > /dev/null 2>&1
fi
