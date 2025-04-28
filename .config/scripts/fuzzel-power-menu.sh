#!/usr/bin/env bash

$MENU=""
read -r -d '' MENU << EOF
  Shutdown
  Reboot
  Lock
󰒲  Suspend
󰍃  Logout
EOF

# Launch fuzzel
CHOICE=$(printf '%s\n' "$MENU" \
         | fuzzel --dmenu \
             --anchor top \
             --lines 5 \
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
    *Logout)   hyprctl dispatch exit ;;
esac
