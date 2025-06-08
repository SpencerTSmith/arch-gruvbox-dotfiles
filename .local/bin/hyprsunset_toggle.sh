#!/usr/bin/env bash

FLAG="$XDG_STATE_HOME/hyprsunset_on"
if [ -f "$FLAG" ]; then
  hyprctl hyprsunset identity && rm "$FLAG"
else
  hyprctl hyprsunset temperature 3000 && touch "$FLAG"
fi
