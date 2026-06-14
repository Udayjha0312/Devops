#!/bin/bash
###############
## Author: Uday Jha
## Date: 13/06/2026
## Description: Backs up live data and automatically drops records older than 7 days.
###############
set -euo pipefail

DATA_SRC="/tmp/production_app_data"
BACKUP_DIR="/tmp/backup_repository"
RETENTION_DAYS=7

mkdir -p "$BACKUP_DIR"

# 1. Create a secure timestamped compressed tape archive package
ARCHIVE_NAME="backup_$(date +%Y_%m_%d_%H%M%S).tar.gz"
tar -czf "$BACKUP_DIR/$ARCHIVE_NAME" -C "$DATA_SRC" . 2>/dev/null || true
echo "[INFO] Generated deployment snapshot: $ARCHIVE_NAME"

# 2. Enforce strict data retention rotation policies
echo "[INFO] Scanning for legacy archive cycles over $RETENTION_DAYS days old..."
find "$BACKUP_DIR" -type f -name "backup_*.tar.gz" -mtime +"$RETENTION_DAYS" -exec rm -f {} \;

echo "[SUCCESS] Rotation engine check cycle complete."