#!/usr/bin/env bash

MENU=""
read -r -d '' MENU << EOF
  Update
  Dropper
  Wallpaper
󱎘  Kill
EOF

CHOICE=$(printf '%s\n' "$MENU" \
         | fuzzel --dmenu \
             --anchor top \
             --lines $(wc -l <<< $MENU) \
             --width 13 \
             --y-margin 5 \
             --x-margin 5 \
             --select-index 0 \
             --prompt "[ACTION]: " \
           )


case "$CHOICE" in
    *Update)    hyprctl dispatch exec "[float] foot -e paru" ;;
    *Wallpaper) fuzzel-wallpaper.sh ;;
    *Dropper)   hyprpicker -laq ;;
    *Kill)      fuzzel-kill.sh ;;
esac
