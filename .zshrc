source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
ZLE_RPROMPT_INDENT=0
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/spence/.zshrc'

export EDITOR=nvim
export VISUAL=nvim

autoload -Uz compinit
compinit
# End of lines added by compinstall

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

eval "$(starship init zsh)"
alias config='/usr/bin/git --git-dir=/home/spence/.dotfiles --work-tree=/home/spence'
