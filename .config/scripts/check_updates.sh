#!/usr/bin/env bash

updates=$(checkupdates | wc -l)

# JSON, for waybar
if [ "$updates" -gt 0 ]; then
    echo "{\"text\": \"$updates\", \"tooltip\": \"$updates updates available\", \"class\": \"updates-available\"}"
else
    echo "{\"text\": \"0\", \"tooltip\": \"No updates available\", \"class\": \"no-updates\"}"
fi
