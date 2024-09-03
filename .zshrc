bindkey -v

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
ZLE_RPROMPT_INDENT=0

autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zmodload zsh/complist
compinit

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

export EDITOR=nvim
export VISUAL=nvim

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(starship init zsh)"
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
