export PATH="$PATH:$HOME/.local/bin/"

if [[ -z "$TMUX" ]] && uwsm check may-start; then
    exec uwsm start hyprland.desktop
fi
