#!/bin/bash
###############
## Author: Uday Jha
## Date: 13/06/2026
## Description: Extracts top 5 unique IPs with the highest 404 error counts.
###############
set -euo pipefail

LOG_FILE="nginx_access.log"

if [ ! -f "$LOG_FILE" ]; then
    echo "[ERROR] Log file missing: $LOG_FILE" >&2
    exit 1
fi

echo "=== TOP 5 BAD ACTORS (404 RESPONSES) ==="
# Target column 9 ($9) for exact HTTP status code matching
awk '$9 == "404" {print $1}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -n 5