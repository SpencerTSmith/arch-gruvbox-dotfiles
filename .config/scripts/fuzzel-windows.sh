#!/usr/bin/env bash

# Adapted to bash from https://github.com/MrSom3body/dotfiles/blob/main/pkgs/fuzzel-goodies/scripts/fuzzel-windows.fish
clients=$(hyprctl clients -j)
readarray -t classes < <(echo "$clients" | jq -r '.[] | .class')
readarray -t titles < <(echo "$clients" | jq -r '.[] | .title')
readarray -t addresses < <(echo "$clients" | jq -r '.[] | .address')

choices=""
for ((i=0; i<${#classes[@]}; i++)); do
    if [[ "${classes[i]}" == *.*.* ]]; then
        choices+="${titles[i]}\t${classes[i]}\0icon\x1f${classes[i]}\n"
    else
        class="${classes[i],,}"
        choices+="${titles[i]}\t${classes[i]}\0icon\x1f$class\n"
    fi
done

choices="${choices%\\n}"

choice=$(echo -e "$choices" | fuzzel --dmenu --prompt "[WINDOW]: " --index --width 50 --tabs 200) || exit

hyprctl dispatch focuswindow "address:${addresses[choice]}"
