#!/bin/sh
set -eu

BASE="/mnt"
BACKUP_ROOT="${BASE}/restore"
TIMESTAMP=$(date +'%Y%m%d_%H%M%S')

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"; }

backup() {
  src=$1
  main_dir=$(echo "$src" | cut -d/ -f3)
  user_dir=$(basename "$src")
  dest="${BACKUP_ROOT}/${main_dir}"
  mkdir -p "$dest"
  archive="${dest}/${user_dir}_${TIMESTAMP}.tar.gz"
  log "Backing up $src -> $archive"
}

for dir in $(find "$BASE" -mindepth 2 -maxdepth 2 -type d ! -path "${BACKUP_ROOT}/*"); do
  backup "$dir"
done

log "Backup complete."
