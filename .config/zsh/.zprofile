export PATH="$PATH:$HOME/.local/bin/"

if uwsm check may-start; then
    exec uwsm start hyprland.desktop
fi
