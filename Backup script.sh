#!/bin/bash



# Source directories to be backed up

SOURCE_DIRS=(

  "/home/anvar/mysourcedir1"

  "/home/anvar/mysourcedir2"

)



# Backup destination directory

BACKUP_DIR="/home/anvar/mybackupdir"



# Maximum number of backup files to keep

MAX_BACKUPS=5



# Current date and time for backup file naming

DATE=$(date +%Y%m%d%H%M%S)



# Create backup filename with timestamp

BACKUP_FILE="backup_$DATE.tar.gz"



# Create backup archive

tar -czvf "$BACKUP_DIR/$BACKUP_FILE" "${SOURCE_DIRS[@]}"



# Delete old backup files if the number exceeds the limit

BACKUP_COUNT=$(ls -1 "$BACKUP_DIR" | grep -c "^backup_.*\.tar\.gz$")

if [ "$BACKUP_COUNT" -gt "$MAX_BACKUPS" ]; then

  OLDEST_BACKUPS=$(ls -1t "$BACKUP_DIR" | grep "^backup_.*\.tar\.gz$" | tail -n $(($BACKUP_COUNT - $MAX_BACKUPS)))

  for FILE in $OLDEST_BACKUPS; do

    rm "$BACKUP_DIR/$FILE"

  done

fi

