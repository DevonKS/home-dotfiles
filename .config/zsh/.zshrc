export PATH=$PATH:/home/devon/apps/bin
export PATH=$PATH:/home/devon/scripts

export GOPATH=$HOME/development/go
export PATH=$PATH:$GOPATH/bin

export PATH=$PATH:/home/devon/apps/platform-tools

# Load Git completion
zstyle ':completion:*:*:git:*' script ~/.config/zsh/git-completion.bash
fpath=(~/.config/zsh $fpath)

autoload -Uz compinit && compinit

alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dfs='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
compdef dotfiles=git
compdef dfs=git
alias vi='nvim'
alias vim='nvim'

# some ls aliases
alias ll='ls -alhF --color'
alias la='ls -A --color'
alias l='ls -CF --color'

[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh

