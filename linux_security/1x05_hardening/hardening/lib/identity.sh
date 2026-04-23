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

    log $REPORT_FILE "INFO" "Set password policy."
}

set_password_max_age() {
    if grep -Eq '^[[:space:]]*#?[[:space:]]*PASS_MAX_DAYS[[:space:]]' $1
    then
        sed -i -r "s|^[[:space:]]*#?[[:space:]]*PASS_MAX_DAYS[[:space:]]+.*$|PASS_MAX_DAYS\t$2|" $1
    else
        echo "PASS_MAX_DAYS	$2" >> $1
    fi

    log $REPORT_FILE "INFO" "Set PASS_MAX_DAYS to $2 days."
}

lockout() {
    sed -i -r "s|^#[[:space:]]*deny.*|deny = $2|" $1

    log $REPORT_FILE "INFO" "Set password max attempt to 5."
}

cleanup() {
    local file="$1"
    shift
    local groups=("$@")
    local deleted_count=0
    local deleted_users=()

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
	    ((++deleted_count))
	    deleted_users+=("$user")
	fi
    done < <(awk -F: '$3>=1000 {print $1}' "$file")

    deleted_users_list=$(IFS=', '; echo "${deleted_users[*]}")

    if [ ${#deleted_users[@]} -eq 0 ]; then
	log $REPORT_FILE "INFO" "None unauthorized user removed."
    else
        log $REPORT_FILE "INFO" "$deleted_count unauthorized users removed: $deleted_users_list"
    fi
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
