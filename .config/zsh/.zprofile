if uwsm check may-start; then
    exec uwsm start hyprland.desktop
fi

# Clean home
export GOPATH="$XDG_DATA_HOME"/go
export GOMODCACHE="$XDG_CACHE_HOME"/go/mod
export GTK_RC_FILES="$XDG_CONFIG_HOME"/gtk-1.0/gtkrc
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc":"$XDG_CONFIG_HOME/gtk-2.0/gtkrc.mine"
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export FFMPEG_DATADIR="$XDG_CONFIG_HOME"/ffmpeg
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export PYTHON_EGG_CACHE="$XDG_CACHE_HOME"/python-eggs
export PYENV_ROOT=$XDG_DATA_HOME/pyenv
export RIPGREP_CONFIG_PATH=$XDG_CONFIG_HOME/ripgrep/config
export PYTHON_HISTORY=$XDG_STATE_HOME/python_history
export PYTHONPYCACHEPREFIX=$XDG_CACHE_HOME/python
export PYTHONUSERBASE=$XDG_DATA_HOME/python
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export WINEPREFIX="$XDG_DATA_HOME"/wineprefixes/default
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export MACHINE_STORAGE_PATH="$XDG_DATA_HOME"/docker-machine
export RUFF_CACHE_DIR=$XDG_CACHE_HOME/ruff
export VSCODE_PORTABLE="$XDG_DATA_HOME"/vscode
