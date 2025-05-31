HISTFILE=~/.zsh_hist
HISTSIZE=10000
SAVEHIST=10000
HISTDUP=erase
KEYTIMEOUT=1
ZLE_RPROMPT_INDENT=0
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt hist_reduce_blanks
setopt auto_cd
setopt correct
setopt glob_dots
setopt IGNORE_EOF

# Completions
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
zmodload zsh/complist
compinit

# Plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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
bindkey -v '^?' backward-delete-char
bindkey -M vicmd 'k' history-search-backward
bindkey -M vicmd 'j' history-search-forward

zle-yank-to-clipboard() {
    # Copy the content to the clipboard
    echo -n "$BUFFER" | wl-copy
}
zle -N zle-yank-to-clipboard
bindkey -M vicmd 'y' zle-yank-to-clipboard

zle-paste-from-clipboard() {
    # Fetch clipboard content and insert it at the cursor position
    local clipboard_content=$(wl-paste)
    RBUFFER+="$clipboard_content"
}
zle -N zle-paste-from-clipboard
bindkey -M vicmd 'p' zle-paste-from-clipboard

zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() { echo -ne "\e[5 q"; }
zle -N zle-line-init

# Annoying ass
stty -ixon

# Swap around ctr l and ctrl d so tmux can still have nice vim keybinds
bindkey "^D" clear-screen
bindkey "^L" list-choices

# Exports
export EDITOR=nvim
export VISUAL=nvim

export PATH="$HOME/.config/scripts/:$PATH"

export MANPAGER="less -R --use-color -Dd+r -Du+b"
export MANROFFOPT="-c"

export SKIM_DEFAULT_COMMAND="fd --type f || git ls-tree -r --name-only HEAD || rg --files || find ."

# Aliases
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME' # dotfiles repo
alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'

alias mkdir='mkdir -pv'
alias rm='rm -iv'
alias cp='cp -iv'
alias mv='mv -iv'
alias chmod='chmod -v'

alias ls='eza --icons --group-directories-first --color=auto'
alias la='eza -alh --icons --group-directories-first --color=auto'
alias tree="eza -T --icons --group-directories-first --color=auto"

alias sk='sk --color=16'

# Git
alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gco='git checkout'
alias gd='git diff'
alias gl='git pull'
alias gp='git push'
alias gs='git status'

alias tma='tmux attach-session -t SCRATCH || tmux new-session -s SCRATCH'

eval "$(zoxide init zsh)"

# Sourcing multiple times will redefine starship... stop that
if [[ "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select" || \
      "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select-wrapped" ]]; then
    zle -N zle-keymap-select "";
fi
eval "$(starship init zsh)"

# Message
~/.config/scripts/phrases.sh
