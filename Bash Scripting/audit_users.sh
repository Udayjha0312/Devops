#!/bin/bash
###############
## Author: Uday Jha
## Date: 13/06/2026
## Description: Filters interactive human system users vs daemon accounts.
###############
set -euo pipefail

PASSWD_FILE="mock_passwd"
REPORT_FILE="human_users.report"

if [ ! -f "$PASSWD_FILE" ]; then
    echo "[ERROR] Identity target missing." >&2
    exit 1
fi

echo "=== HUMAN ACCESS CREDENTIAL AUDIT ===" > "$REPORT_FILE"

# Extract users whose shells DO NOT end with 'nologin' or 'false'
awk -F: '$7 !~ /nologin$/ && $7 !~ /false$/ {print "User: " $1 " -> Shell: " $7}' "$PASSWD_FILE" >> "$REPORT_FILE"

cat "$REPORT_FILE"