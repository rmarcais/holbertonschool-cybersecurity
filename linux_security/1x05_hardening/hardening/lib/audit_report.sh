#!/bin/bash

log() {
    local level=$2
    local message=$3

    echo "[$level] $message" >> $1
}

init_audit_report()
{
    echo "############################################################" >> $1
    echo "# HARDENING AUDIT REPORT $(date -u +%FT%TZ)" >> $1
    echo "############################################################" >> $1
    log $REPORT_FILE "INFO" "Current EUID: $EUID."
    log $REPORT_FILE "INFO" "Hardening framework initialized"
}

end_audit_report()
{
    echo "############################################################" >> $1
    echo "# COMPLIANCE STATUS: $2" >> $1
    echo "############################################################" >> $1
}
