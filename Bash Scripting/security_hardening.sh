#!/bin/bash
###############
## Author: Uday Jha
## Date: 13/06/2026
## Description: Audits configuration paths for leaks and drops privileges to 600
###############
set -euo pipefail

TARGET_PATH="./app_config"

echo "[INFO] Initiating secret leakage scan..."

# Find all files inside the configuration directory path
find "$TARGET_PATH" -type f | while read -r filepath; do
    # Check if the file contents mention high-security key names
    if grep -qEI "PASSWORD|SECRET|TOKEN" "$filepath"; then
        # Check if the file has wide-open file permissions (e.g., world-readable)
        # stat -c %a fetches the numeric file permission code (like 777)
        CURRENT_PERM=$(stat -c %a "$filepath")
        
        if [ "$CURRENT_PERM" -ne 600 ]; then
            echo "[RISK] Exposed target found: $filepath (Current Perms: $CURRENT_PERM)"
            chmod 600 "$filepath"
            echo "[SECURED] Access restricted to system owner only (600)."
        fi
    fi
done