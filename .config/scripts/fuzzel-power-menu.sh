#!/usr/bin/env bash

fuzzel_kill() {
  PROCESSES=$(ps -u $USER -o pid,comm | awk '{printf "%s - %s\n", $1, $2}')

  # Launch fuzzel with process list
  SELECTED_PROCESS=$(printf '%s\n' "$PROCESSES" \
    | fuzzel --dmenu \
    --anchor center \
    --lines 15 \
    --width 50 \
    --prompt "[KILL]: " \
  )

  # Extract PID and kill the process
  if [[ -n "$SELECTED_PROCESS" ]]; then
    PID=$(echo "$SELECTED_PROCESS" | awk '{print $1}')
    if [[ "$PID" =~ ^[0-9]+$ ]]; then
      kill "$PID" 2>/dev/null
      if [[ $? -eq 0 ]]; then
        notify-send "Process Killed" "Killed process $PID" 2>/dev/null || echo "Killed process $PID"
      else
        notify-send "Kill Failed" "Failed to kill process $PID" 2>/dev/null || echo "Failed to kill process $PID"
      fi
    fi
  fi
}

MENU=""
read -r -d '' MENU << EOF
  Shutdown
  Reboot
  Lock
󰒲  Suspend
󰍃  Exit
  Kill
EOF

# Launch fuzzel
CHOICE=$(printf '%s\n' "$MENU" \
         | fuzzel --dmenu \
             --anchor top \
             --lines 6 \
             --width 20 \
             --y-margin 5 \
             --select-index 2 \
             --prompt "[POWER]: " \
           )


# Act on the choice
case "$CHOICE" in
    *Shutdown) systemctl poweroff ;;
    *Reboot)   systemctl reboot ;;
    *Lock)     hyprlock ;;
    *Suspend)  systemctl suspend ;;
    *Exit)     uwsm stop ;;
    *Kill)     fuzzel_kill ;;
esac
