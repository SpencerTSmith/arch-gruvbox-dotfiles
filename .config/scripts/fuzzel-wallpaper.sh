#!/usr/bin/env bash

WALLPAPER_DIR=$HOME/.config/wallpapers
WALLPAPER_DIR_WRITE=\$HOME/.config/wallpapers
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
  hyprctl hyprpaper reload , "$WALLPAPER_DIR/$CHOICE"
  echo -e "preload = $WALLPAPER_DIR_WRITE/$CHOICE\nwallpaper = , $WALLPAPER_DIR_WRITE/$CHOICE" > $HYPRPAPER_DIR/hyprpaper.conf
fi
