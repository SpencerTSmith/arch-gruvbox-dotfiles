[ -d "$XDG_STATE_HOME"/zsh ] || mkdir -p "$XDG_STATE_HOME"/zsh
HISTFILE="$XDG_STATE_HOME"/zsh/history
HISTSIZE=10000
SAVEHIST=10000
HISTDUP=erase
KEYTIMEOUT=1
ZLE_RPROMPT_INDENT=0
setopt append_history
setopt share_history
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt hist_reduce_blanks
setopt auto_cd
setopt correct
setopt glob_dots
setopt always_to_end
setopt complete_aliases
setopt auto_menu
setopt IGNORE_EOF
setopt auto_param_slash
setopt no_case_glob
setopt no_case_match
setopt globdots
setopt extended_glob
setopt interactive_comments

# Completions
[ -d "$XDG_CACHE_HOME"/zsh ] || mkdir -p "$XDG_CACHE_HOME"/zsh
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:warnings' format 'No matches: %d'
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME"/zsh/zcompcache
zmodload zsh/complist
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-$ZSH_VERSION

# Plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Vim key binds
bindkey -v
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

bindkey '^N' expand-or-complete
bindkey '^P' reverse-menu-complete
bindkey -M menuselect '^N' menu-complete
bindkey -M menuselect '^P' reverse-menu-complete

bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word

bindkey -M vicmd 'k' up-line-or-history
bindkey -M vicmd 'j' down-line-or-history

zle-yank-to-clipboard() {
  if [[ -n $REGION_ACTIVE ]]; then
    local start_pos end_pos
    if (( MARK < CURSOR )); then
      start_pos=$MARK
      end_pos=$CURSOR
    else
      start_pos=$CURSOR
      end_pos=$MARK
    fi
    local selected_text="${BUFFER:$start_pos:$(($end_pos - $start_pos + 1))}"
    echo -n "$selected_text" | wl-copy
    REGION_ACTIVE=0
  else
    echo -n "$BUFFER" | wl-copy
  fi
}
zle -N zle-yank-to-clipboard

zle-paste-from-clipboard() {
  local clipboard_content=$(wl-paste)
  BUFFER="${BUFFER:0:$CURSOR}$clipboard_content${BUFFER:$CURSOR}"
  CURSOR=$(($CURSOR + ${#clipboard_content}))
}
zle -N zle-paste-from-clipboard

bindkey -M vicmd 'y' zle-yank-to-clipboard
bindkey -M vicmd 'p' zle-paste-from-clipboard
bindkey -M visual 'y' zle-yank-to-clipboard

autoload -U select-quoted
  zle -N select-quoted
  for m in visual viopp; do
    for c in {a,i}{\',\",\`}; do
      bindkey -M $m $c select-quoted
    done
  done

# Annoying ass
stty -ixon

# Swap around ctr l and ctrl d so tmux can still have nice vim keybinds
bindkey "^D" clear-screen
bindkey "^L" list-choices
bindkey -M vicmd "^D" clear-screen
bindkey -M vicmd "^L" list-choices

# Exports
export EDITOR=nvim
export VISUAL=nvim

export MANPAGER="less -R -M -i -j10"
export MANROFFOPT="-c"

export LESS_TERMCAP_md=$'\e[1;94m'
export LESS_TERMCAP_us=$'\e[1;92m'
export LESS_TERMCAP_so=$'\e[103;30m'
export LESS_TERMCAP_mb=$'\e[1;91m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_ue=$'\e[0m'

export FZF_DEFAULT_OPTS='--color=16 --tmux "bottom,100%,100%"'

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
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java

# Aliases
alias vi='nvim'
alias vim='nvim'
alias vimdiff='nvim -d'

alias neofetch='fastfetch --config neofetch.jsonc'

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME' # dotfiles repo

alias mkdir='mkdir -pv'
alias rm='rm -iv'
alias cp='cp -iv'
alias mv='mv -iv'
alias chmod='chmod -v'

alias ls='eza --icons --group-directories-first --color=auto'
alias la='eza -alh --icons --group-directories-first --color=auto'
alias tree="eza -T --icons --group-directories-first --color=auto"

# Functions
function mkcd() {
  mkdir -p $@ && $@;
}

# Convenience
alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gco='git checkout'
alias gd='git diff'
alias gl='git pull'
alias gp='git push'
alias gs='git status'
alias tma='tmux attach-session || tmux new-session -s SCRATCH'

# Prompt
zle -N zle-keymap-select
zle-line-init() { echo -ne "\e[5 q"; }
zle -N zle-line-init
zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac

    zle reset-prompt
}
zle -N zle-keymap-select

setopt prompt_subst
PROMPT='%B%F{9}[%F{11}%n%F{10}@%F{12}%m%F{9}] %F{13}%2~
%(?.%F{15}.%F{9}) λ%f%b '

# Message
phrases.sh
