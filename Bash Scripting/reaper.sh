#!/bin/bash
#################
## Author: Uday Jha
## Date: 14/06/2026
# Description: Locates, logs, and kills zombie threads of a specific app name
#################
set -euo pipefail

TARGET_PROCESS="dummy_app"
AUDIT_LOG="zombie_reaper.log"

# Search for the process names omitting grep's own PID footprint
PID_LIST=$(pgrep -f "$TARGET_PROCESS" || true)

if [ -z "$PID_LIST" ]; then
    echo "[INFO] No lingering threads detected for: $TARGET_PROCESS"
    exit 0
fi

for pid in $PID_LIST; do
    echo "[%s] Terminated lingering instance PID: %s\n" "$(date)" "$pid" >> "$AUDIT_LOG"
    echo "[KILLING] Purging process thread ID: $pid"
    kill -15 "$pid" # Send standard Graceful Termination Signal
done