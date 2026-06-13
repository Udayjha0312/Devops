#!/bin/bash
#################
## Author: Uday Jha
## Date: 14/06/2026
## Description: Compresses and truncates log files if disk space > 85%
#################

set -euo pipefail

TARGET_DIR="./app_logs"
THRESHOLD=85

# Fetch the current root partition space utilization percentage
CURRENT_USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')

echo "[INFO] Current Root Partition Disk Usage: ${CURRENT_USAGE}%"

if [ "$CURRENT_USAGE" -gt "$THRESHOLD" ]; then
    echo "[WARN] Disk space threshold breached! Running clean-up operations..."
    
    # Locate all files ending in .log recursively
    find "$TARGET_DIR" -type f -name "*.log" | while read -r logfile; do
        echo "[PROCESSING] Archiving: $logfile"
        tar -czf "${logfile}_$(date +%F_%s).tar.gz" "$logfile"
        
        # Truncate the original log file to empty it safely without dropping handles
        > "$logfile"
    done
    echo "[SUCCESS] Cleanup routine completed."
else
    echo "[OK] Storage levels are within nominal boundaries."
fi