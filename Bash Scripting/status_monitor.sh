#!/bin/bash
###############
## Author: Uday Jha
## Date: 13/06/2026
## Description: Evaluates component health structures out of JSON data targets
###############
set -euo pipefail

# Read local file via file URI scheme to mock real internet curl endpoints
API_TARGET="file://$(pwd)/cloud_status.json"
PAYLOAD=$(curl -s "$API_TARGET")

# Extract top level status metrics
GLOBAL_STATUS=$(echo "$PAYLOAD" | jq -r '.status')

if [ "$GLOBAL_STATUS" != "operational" ]; then
    echo "[ALERT] Upstream cloud degradation verified! Core cluster status: $GLOBAL_STATUS"
    echo "=== IMPACTED COMPONENT SPECIFICS ==="
    
    # Filter and extract fields where state value does not equal operational
    echo "$PAYLOAD" | jq -r '.components | to_entries[] | select(.value != "operational") | "Component: \(.key) is currently [\(.value)]"'
else
    echo "[HEALTHY] External dependency layers operational."
fi