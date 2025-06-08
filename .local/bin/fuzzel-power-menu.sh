#!/usr/bin/env bash

MENU=""
read -r -d '' MENU << EOF
  Shutdown
  Reboot
  Lock
󰒲  Suspend
󰍃  Exit
EOF

# Launch fuzzel
CHOICE=$(printf '%s\n' "$MENU" \
         | fuzzel --dmenu \
             --anchor top \
             --lines $(wc -l <<< $MENU) \
             --width $(wc -L <<< $MENU) \
             --y-margin 5 \
             --prompt "[POWER]: " \
           )


# Act on the choice
case "$CHOICE" in
    *Shutdown) systemctl poweroff ;;
    *Reboot)   systemctl reboot ;;
    *Lock)     hyprlock ;;
    *Suspend)  systemctl suspend ;;
    *Exit)     uwsm stop ;;
esac
