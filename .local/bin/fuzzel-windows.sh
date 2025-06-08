#!/usr/bin/env bash

# Adapted to bash from https://github.com/MrSom3body/dotfiles/blob/main/pkgs/fuzzel-goodies/scripts/fuzzel-windows.fish
clients=$(hyprctl clients -j)
readarray -t classes < <(echo "$clients" | jq -r '.[] | .class')
readarray -t titles < <(echo "$clients" | jq -r '.[] | .title')
readarray -t addresses < <(echo "$clients" | jq -r '.[] | .address')

choices=""
for ((i=0; i<${#classes[@]}; i++)); do
  class="${classes[i],,}"
  class="${class/footclient/foot}" # For some reason footclient doesn't show up right!
  choices+="${titles[i]}\t${classes[i]}\0icon\x1f$class\n"
done

choices="${choices%\\n}"

choice=$(echo -e "$choices" | fuzzel --dmenu --prompt "[WINDOW]: " --index --width 40 --tabs 200) || exit

hyprctl dispatch focuswindow "address:${addresses[choice]}"
