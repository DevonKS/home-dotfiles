export PS1="[\t] $PS1"
export PATH=$PATH:/home/devon/apps/bin
export PATH=$PATH:/home/devon/scripts

export GOPATH=$HOME/development/go
export PATH=$PATH:$GOPATH/bin

export PATH=$PATH:/home/devon/apps/platform-tools

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dfs='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias vi='nvim'
alias vim='nvim'


[ -f /usr/share/fzf/key-bindings.bash ] && source /usr/share/fzf/key-bindings.bash

