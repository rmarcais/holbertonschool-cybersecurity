#!/bin/bash

system_update() {
    if apt-get update; then
        log $REPORT_FILE "INFO" "Package updates OK"
    else
        log $REPORT_FILE "ERROR" "Package updates FAILED"
	mark_status_failed
	return 1
    fi

    if apt-get -s upgrade | grep -q "0 upgraded"; then
	log $REPORT_FILE "WARN" "Package updates skipped (already up to date)."
        return 0
    fi

    if apt-get upgrade -y; then
	log $REPORT_FILE "INFO" "Package upgrades OK"
    else
        log $REPORT_FILE "ERROR" "Package upgrades FAILED"
	mark_status_failed
    fi
}

uninstall_bloatwares() {
    if apt-get remove -y "${BLOATWARES[@]}"; then
        log $REPORT_FILE "INFO" "Removed: $(IFS=,; echo "${BLOATWARES[*]}")."
    fi
}

install_tools() {
    if apt-get install -y "${TOOLS_TO_INSTALL[@]}"; then
        log $REPORT_FILE "INFO" "Installed: $(IFS=,; echo "${TOOLS_TO_INSTALL[*]}")."
    fi
}

# Updates
system_update

# Uninstalls bloatwares
uninstall_bloatwares

# Installs tools
install_tools
