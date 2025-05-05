#!/usr/bin/env bash

# Update
paru
# Send a signal to refresh the waybar module
pkill -RTMIN+10 waybar
