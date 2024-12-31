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
bindkey '^N' down-line-or-history     # Ctrl-N: Next history
bindkey '^P' up-line-or-history       # Ctrl-P: Previous history

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
    LBUFFER+="$clipboard_content"
}
zle -N zle-paste-from-clipboard
bindkey -M vicmd 'p' zle-paste-from-clipboard

# Exports
export EDITOR=nvim
export VISUAL=nvim

# Plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Aliases
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

eval "$(starship init zsh)"
