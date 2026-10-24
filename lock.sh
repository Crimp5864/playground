#!/usr/bin/env bash

LOCK_FILE="/tmp/myscript.lock"

if [[ -e "$LOCK_FILE" ]]; then
  echo "Error: Script is already running (lockfile exists: $LOCK_FILE)." >&2
  exit 1
fi

# Create lockfile and cleanup on exit
touch "$LOCK_FILE"
trap 'rm -f "$LOCK_FILE"' EXIT

echo 'This is the main logic of the script.'

echo 'The script will exit now.'
