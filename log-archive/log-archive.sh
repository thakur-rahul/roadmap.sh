#!/bin/bash

# Log archiving tool with email notification
# Usage: ./log-archive.sh /var/log recipient@example.com

if [ $# -lt 2 ]; then
  echo "Usage: $0 <log-directory> <recipient-email>"
  exit 1
fi

LOG_DIR=$1
RECIPIENT=$2
ARCHIVE_DIR="./archives"

# Ensure archive directory exists
mkdir -p "$ARCHIVE_DIR"

# Timestamp for archive name
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
ARCHIVE_NAME="logs_archive_${TIMESTAMP}.tar.gz"
ARCHIVE_PATH="${ARCHIVE_DIR}/${ARCHIVE_NAME}"

# Create tar.gz archive
tar -czf "$ARCHIVE_PATH" -C "$LOG_DIR" .

# Log the archive creation
LOG_FILE="${ARCHIVE_DIR}/archive_log.txt"
echo "${TIMESTAMP} - Archived ${LOG_DIR} to ${ARCHIVE_NAME}" >> "$LOG_FILE"

# Email notification
SUBJECT="Log Archive Created - ${TIMESTAMP}"
BODY="The logs from ${LOG_DIR} have been archived into ${ARCHIVE_NAME} at ${TIMESTAMP}."

# Using 'mail' command (ensure mailutils or postfix is installed)
echo "$BODY" | mail -s "$SUBJECT" "$RECIPIENT"

echo "✅ Archive created: $ARCHIVE_PATH"
echo "📧 Notification sent to: $RECIPIENT"
