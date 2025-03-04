#!/bin/bash

# Obtain folder path
p=$(dirname $(dirname $(realpath $0)))

# .env path
ENV_PATH="${p}/directus-backup/.env"

# Load the .env file
source ${ENV_PATH}

# Variables
DATE=$(date +"%Y%m%d%H%M%S")
BACKUP_LOCAL="${BACKUP_DIR_LOCAL}/long_term_bckp/${DATE}"
BACKUP_DISTANT="${BACKUP_DIR_DISTANT}/long_term_bckp/${DATE}"

# Redirect all output to the log file
exec &>> "$LOG_FILE_LONG"

# Enable immediate exit on error
set -e

mkdir -p "${BACKUP_LOCAL}/${DATE}"
mkdir -p "${BACKUP_DISTANT}/${DATE}"

# Perform backup
tar -czf "${BACKUP_LOCAL}/${DATE}/backup.tar.gz" -C "$POSTGRES_DIR" .
tar -czf "${BACKUP_DISTANT}/${DATE}/backup.tar.gz" -C "$POSTGRES_DIR" .

# Check if backup was successful
if [ $? -eq 0 ]; then
    echo "Backup completed successfully"
else
    echo "Backup failed"
    exit 1
fi

# Keep only the latest backups
cleanup_backups() {
    local backup_dir="$1"
    if [ -n "$(ls -A "$backup_dir")" ]; then
        ls -dt "$backup_dir"/* | tail -n +"$((${RETAIN_BACKUPS_LONG}+2))" | xargs rm -rf
    fi
}

cleanup_backups "$BACKUP_DIR_LOCAL/short_term_bckp"