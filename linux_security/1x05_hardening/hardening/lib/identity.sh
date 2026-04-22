#!/bin/bash

set_password_policy() {
    local rule="password        requisite                       pam_pwquality.so minlen=$2 minclass=$3"

    if grep -Eq '^[[:space:]]*password[[:space:]]+requisite[[:space:]]+pam_pwquality\.so' $1
    then
        sed -i -r 's|^[[:space:]]*password[[:space:]]+requisite[[:space:]]+pam_pwquality\.so.*$|"$rule"|' $1
    else
        local tmp=$(mktemp)
        awk -v rule="$rule" '!done && $0 ~ /^[[:space:]]*password[[:space:]]+.*pam_unix\.so/ { print rule; done=1 } {print}' $1 > $tmp
        mv $tmp $1
    fi
}

set_password_max_age() {
    if grep -Eq '^[[:space:]]*#?[[:space:]]*PASS_MAX_DAYS[[:space:]]' $1
    then
        sed -i -r "s|^[[:space:]]*#?[[:space:]]*PASS_MAX_DAYS[[:space:]]+.*$|PASS_MAX_DAYS\t$2|" $1
    else
        echo "PASS_MAX_DAYS	$2" >> $1
    fi
}

lockout() {
    sed -i -r "s|^#[[:space:]]*deny.*|deny = $2|" $1
}

cleanup() {
    local file="$1"
    shift
    local groups=("$@")

    awk -F: '{if ($3>=1000) print $1 }' $file |
    while read -r user; do
        local user_groups=$(id -nG "$user" 2>/dev/null)
	local found=0

        for g in "${groups[@]}"; do
	    if echo $user_groups | grep -qw $g; then
		found=1
		break
	    fi
        done

	if [ $found -eq 0 ] && [ "$user" != $CURRENT_USER ]; then
	    deluser "$user"
	fi
    done
}

lock_password() {
    passwd -l $1
}

# Set password policy (min length and complexity)
set_password_policy $PAM_COMMON_PASSWORD $PASS_MIN_LEN $PASS_MIN_CLASS $PASS_MAX_DAYS

# Set password max age
set_password_max_age $LOGIN_DEFS $PASS_MAX_DAYS

# Locks account after 5 failed login attempts
lockout $FAILLOCK_CFG $FAIL_LOCK_ATTEMPTS

# Deletes users with UID > 1000 not in certains gorups
cleanup $ETC_PASSWD "${ALLOWED_GROUPS[@]}"

# Locks root password
lock_password $USER_TO_LOCK
