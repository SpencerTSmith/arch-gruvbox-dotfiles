#!/usr/bin/env bash

MENU=""
read -r -d '' MENU << EOF
  Update
  Shutdown
  Reboot
  Lock
󰒲  Suspend
󰍃  Exit
󱎘  Kill
EOF

# Launch fuzzel
CHOICE=$(printf '%s\n' "$MENU" \
         | fuzzel --dmenu \
             --anchor top \
             --lines 7 \
             --width 20 \
             --y-margin 5 \
             --select-index 0 \
             --prompt "[POWER]: " \
           )


# Act on the choice
case "$CHOICE" in
    *Update)   hyprctl dispatch exec "[float] foot -e paru" ;;
    *Shutdown) systemctl poweroff ;;
    *Reboot)   systemctl reboot ;;
    *Lock)     hyprlock ;;
    *Suspend)  systemctl suspend ;;
    *Exit)     uwsm stop ;;
    *Kill)     $HOME/.config/scripts/fuzzel-kill.sh ;;
esac
