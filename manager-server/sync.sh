#!/bin/bash
# Incremental sync from /data to OneDrive (or Google Drive)
# Only transfers changed files — efficient for large .manager files

REMOTE="${RCLONE_REMOTE:-onedrive:ManagerBackup}"
LOCAL="/data"

echo "[$(date)] Starting sync: $LOCAL → $REMOTE"

# Sync local to remote (incremental — only changed files)
rclone sync "$LOCAL" "$REMOTE" \
  --checksum \
  --transfers 2 \
  --log-level INFO

echo "[$(date)] Sync complete"
