#!/bin/bash

apt-get update
apt-get install -y $1

file=$2
rule="password        requisite                       pam_pwquality.so minlen=12 minclass=3"

if grep -Eq '^[[:space:]]*password[[:space:]]+requisite[[:space:]]+pam_pwquality\.so' $file
then
    sed -ir 's|^[[:space:]]*password[[:space:]]+requisite[[:space:]]+pam_pwquality\.so.*$|"$rule"|' $file
else
    tmp=$(mktemp)
    awk -v rule="$rule" '!done && $0 ~ /^[[:space:]]*password[[:space:]]+.*pam_unix\.so/ { print rule; done=1 } {print}' $file > $tmp
    mv $tmp $file
fi
