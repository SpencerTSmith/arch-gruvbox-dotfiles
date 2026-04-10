#!/usr/bin/env bash

WALLPAPER_DIR=$HOME/Pictures/wallpapers
WALLPAPER_DIR_WRITE=\$HOME/Pictures/wallpapers
WALLPAPERS=$(find $WALLPAPER_DIR -type f -printf "%f\n")

HYPRPAPER_DIR=$HOME/.config/hypr/

CHOICE=$(printf '%s\n' "$WALLPAPERS" \
         | fuzzel --dmenu \
             --anchor bottom \
             --lines $(wc -l <<< $WALLPAPERS) \
             --width $(($(wc -L <<< $WALLPAPERS) - 3)) \
             --y-margin 5 \
             --prompt "[WALLPAPER]: " \
           )

if [[ -n "$CHOICE" ]]; then
  hyprctl hyprpaper wallpaper ", $WALLPAPER_DIR/$CHOICE"
  echo -e " wallpaper {\n  monitor =\n  path = $WALLPAPER_DIR/$CHOICE\n}" > $HYPRPAPER_DIR/hyprpaper.conf
fi
