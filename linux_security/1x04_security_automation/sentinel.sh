#!/bin/bash
CONFIG_FILE="./sentinel.conf"
BACKUPS="/var/backups/sentinel/"

if [ ! -z "$CONFIG_FILE" ] && [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
else
    echo "Error: config file is missing"
    exit 1
fi

: "${SERVICES:?Variable SERVICES not defined}"
: "${FILES_TO_WATCH:?Variable FILES_TO_WATCH not defined}"

check_services() {
    for svc in "${SERVICES[@]}"
    do
	if pgrep -f "$svc" > /dev/null; then
	    echo "OK: $svc is running"
	else
	    if eval "$svc" > /dev/null; then
	        echo "FIXED: Restarted $svc"
	    else
		echo "Error starting $svc"
	    fi
	fi
    done
}

check_services

check_integrity() {
    for ftw in "${FILES_TO_WATCH[@]}"
    do
	GOLD_COPY="$BACKUPS${ftw##*/}.gold"
	HASH_GOLD_COPY=$(md5sum "$GOLD_COPY" | awk '{print $1}')
	HASH_FTW=$(md5sum "$ftw" | awk '{print $1}')

	if [ "$HASH_GOLD_COPY" = "$HASH_FTW" ]; then
	    echo "OK: $ftw integrity verified"
	else
	    if cp "$GOLD_COPY" "$ftw" > /dev/null; then
                echo "FIXED: Restored $ftw"
            else
                echo "Error checking integrity of $ftw"
            fi

	fi
    done
}

check_integrity

check_ports() {
    LISTENING_PORTS=$(ss -lnt4 | awk 'NR>1 {split($4,a,":"); print a[2]}')
    for lp in $LISTENING_PORTS
    do
	found=0
        for p in "${ALLOWED_PORTS[@]}"
        do
            if [ "$lp" == "$p" ]
	    then
		found=1
		break
	    fi
	done

	if [ "$found" -eq 0 ]
	then
	    fuser -k $lp/tcp > /dev/null
	    echo "ALERT: Killed rogue process on port $lp"
	fi
    done
}

check_ports

