#!/bin/bash
##################
## Author: Uday Jha
## Date: 13/05/2026
## Description: Isolates high-priority stack traces and errors out clean summaries.
set -euo pipefail

INPUT_LOG="app_execution.log"

if [ ! -f "$INPUT_LOG" ]; then
    echo "[ERROR] Trace targets unavailable." >&2
    exit 1
fi

# Search for either match pattern safely using Extended Regex
if grep -qE "CRITICAL|FATAL" "$INPUT_LOG"; then
    echo "=== DISPATCHING ALERT ACTIONS ==="
    grep -E "CRITICAL|FATAL" "$INPUT_LOG" | while read -r line; do
        # Extract timestamp brackets and strip severity identifiers out
        TIMESTAMP=$(echo "$line" | awk -F'[][]' '{print $2}')
        ERR_MSG=$(echo "$line" | awk -F' (CRITICAL|FATAL) ' '{print $2}')
        echo "[ALERT] Triggered at ($TIMESTAMP) -> $ERR_MSG"
    done
else
    echo "[OK] System healthy."
fi