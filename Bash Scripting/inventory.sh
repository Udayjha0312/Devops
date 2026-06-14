#!/bin/bash
###############
## Author: Uday Jha
## Date: 13/06/2026
## Description: Converts deep nested JSON infra payloads directly into clean CSV layouts.
###############
## Author: Uday Jha
## Date: 13/06/2026
set -euo pipefail

INFRA_JSON="infrastructure_inventory.json"
CSV_OUT="infrastructure_snapshot.csv"

if [ ! -f "$INFRA_JSON" ]; then
    echo "[ERROR] Source topology metadata file missing." >&2
    exit 1
fi

echo "INSTANCE_ID,PRIVATE_IP,ENVIRONMENT,ROLE" > "$CSV_OUT"

# Flatten out matrix details using single-line raw string evaluations
jq -r '.[] | "\(.instance_id),\(.private_ip),\(.environment),\(.role)"' "$INFRA_JSON" >> "$CSV_OUT"

echo "[SUCCESS] CSV compilation finalized."
cat "$CSV_OUT"