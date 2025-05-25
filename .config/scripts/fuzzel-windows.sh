#!/usr/bin/env bash

CLIENTS=$(hyprctl clients -j)
CLASSES=$(echo $CLIENTS | jq -r '.[] | .class')
TITLES=$(echo $CLIENTS | jq -r '.[] | .title')
ADDRESSES=$(echo $CLIENTS | jq -r '.[] | .address')
CHOICES=""

for i in "${!CLASSES[@]}"; do
  CLASS="${CLASSES[$i]}"
  TITLE="${TITLES[$i]}"
  ADDRESS="${ADDRESSES[$i]}"

  if [[ "$CLASS" == *.*.* ]]; then
    choices+="${TITLE}\t${class}\0icon\x1f${CLASS}\n"
