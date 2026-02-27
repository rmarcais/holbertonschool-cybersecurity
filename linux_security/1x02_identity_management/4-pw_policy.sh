#!/bin/bash

# sudo apt-get update => waiting for permissions
# sudo apt-get install -y libpam-pwquality => waiting for permissions

file=/etc/pam.d/common-password
rule="password        requisite                       pam_pwquality.so minlen=12 minclass=3"
tmp=$(mktemp)

if grep -Eq '^[[:space:]]*password[[:space:]]+requisite[[:space:]]+pam_pwquality\.so' $file
then
    sed -r 's|^[[:space:]]*password[[:space:]]+requisite[[:space:]]+pam_pwquality\.so.*$|"$rule"|' $file > $tmp
else
    awk -v rule="$rule" '!done && $0 ~ /^[[:space:]]*password[[:space:]]+.*pam_unix\.so/ { print rule; done=1 } {print}' $file > $tmp
fi

mv $tmp $file
