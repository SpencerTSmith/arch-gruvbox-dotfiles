HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
ZLE_RPROMPT_INDENT=0

# Completions
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zmodload zsh/complist
compinit

# Vim key binds
bindkey -v
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

zle-yank-to-clipboard() {
    # Yank the current line into a variable
    BUFFER=$(print -rn -- "$BUFFER")
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

setopt IGNORE_EOF

# Swap around ctr l and ctrl d, so tmux can still have nice vim keybinds
bindkey "^D" clear-screen
bindkey "^L" list-choices

# Exports
export EDITOR=nvim
export VISUAL=nvim

# Plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Aliases
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME' # dotfiles repo
alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ~='cd ~'

alias mkdir="mkdir -pv"
alias rm="rm -iv"
alias cp="cp -iv"
alias mv="mv -iv"
alias chmod="chmod -v"
alias ls='ls -alh --color=auto'

alias pyvenv='source venv/bin/activate'

alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gco='git checkout'
alias gd='git diff'
alias gl='git pull'
alias gp='git push'
alias gs='git status'

# Sourcing multiple times will redefine starship... stop that
if [[ "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select" || \
      "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select-wrapped" ]]; then
    zle -N zle-keymap-select "";
fi
eval "$(starship init zsh)"
