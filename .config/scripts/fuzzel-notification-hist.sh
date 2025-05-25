#!/usr/bin/env bash

NOTIFICATIONS=$(makoctl history)

if [ -z "$NOTIFICATIONS" ]; then
  notify-send "Notification History" "Not notifications found in history"
  exit 0
fi

COUNT=$(echo "$NOTIFICATIONS" | grep -c "^Notification [0-9]\+:")

declare -A NOTIFICATION_MAP
DISPLAY_LIST=""

DELIMITER="---------------------"
ENTRY_ID=0

while IFS= read -r line; do
  if [[ $line =~ ^Notification\ ([0-9]+):\ (.*)$ ]]; then
      # If this isn't the first notification, add a delimiter
      if [ $ENTRY_ID -gt 0 ]; then
          DISPLAY_LIST="${DISPLAY_LIST}\n${DELIMITER}\n"
      fi

      current_id="${BASH_REMATCH[1]}"
      current_title="${BASH_REMATCH[2]}"

      # Start a new multi-line entry
      ENTRY_ID=$((ENTRY_ID + 1))
      entry_key="entry_${ENTRY_ID}"

      # First line: ID and title
      current_entry="ID: ${current_id} - ${current_title}"
      app_name=""
      urgency=""

      # Store the notification ID for this entry
      notification_map["$entry_key"]="$current_id"
  elif [[ $line =~ ^\ \ App\ name:\ (.*)$ ]]; then
      app_name="${BASH_REMATCH[1]}"
      # Add app name as a line
      current_entry="${current_entry}\nApp: ${app_name}"
  elif [[ $line =~ ^\ \ Urgency:\ (.*)$ ]]; then
      urgency="${BASH_REMATCH[1]}"
      # Add urgency as a line
      current_entry="${current_entry}\nUrgency: ${urgency}"

      # Add the complete entry to our display list
      DISPLAY_LIST="${DISPLAY_LIST}${current_entry}"
  fi
done <<< "$NOTIFICATIONS"

DISPLAY_LIST=${DISPLAY_LIST%\\n}

SELECTED=$(echo -e "$DISPLAY_LIST" | fuzzel --dmenu \
                                        --anchor top-right \
                                        --y-margin 5 \
                                        --x-margin 5 \
                                        --prompt "[NOTIFY]: " \
                                      )

if [ -z "$SELECTED" ]; then
  exit 0
fi
