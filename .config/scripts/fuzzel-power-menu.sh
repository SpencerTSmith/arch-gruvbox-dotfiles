#!/usr/bin/env bash

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
             --y-margin 5 \
      )

# Act on the choice
case "$CHOICE" in
    *Shutdown)   systemctl poweroff ;;
    *Reboot)     systemctl reboot ;;
    *Lock)       hyprlock ;;
    *Suspend)    systemctl suspend ;;
    *Logout)     hyprctl exit ;;
    *)            ;;  # If you hit Esc or click outside
esac
