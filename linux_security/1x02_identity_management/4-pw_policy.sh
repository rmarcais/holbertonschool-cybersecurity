#!/bin/bash

apt-get update
apt-get install -y $1

file=$2
rule="password        requisite                       pam_pwquality.so minlen=12 minclass=3"
tmp=$(mktemp)

if grep -Eq '^[[:space:]]*password[[:space:]]+requisite[[:space:]]+pam_pwquality\.so' $file
then
    sed -r 's|^[[:space:]]*password[[:space:]]+requisite[[:space:]]+pam_pwquality\.so.*$|"$rule"|' $file > $tmp
else
    awk -v rule="$rule" '!done && $0 ~ /^[[:space:]]*password[[:space:]]+.*pam_unix\.so/ { print rule; done=1 } {print}' $file > $tmp
fi

mv $tmp $file
