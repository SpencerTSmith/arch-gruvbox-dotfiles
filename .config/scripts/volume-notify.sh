#!/usr/bin/env bash

VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
VOLUME=$(echo "$VOLUME" | awk '{print $2}')
VOLUME=$(echo "($VOLUME * 100) / 1" | bc)

notify-send -t 1000 -a 'Volume:' -h string:x-canonical-private-synchronous:sys-notify -h int:value:$VOLUME "  $VOLUME%"
