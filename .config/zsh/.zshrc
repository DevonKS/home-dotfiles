export PATH=$PATH:/home/devon/apps/bin
export PATH=$PATH:/home/devon/scripts

export GOPATH=$HOME/development/go
export PATH=$PATH:$GOPATH/bin

export PATH=$PATH:/home/devon/apps/platform-tools

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias vi='nvim'
alias vim='nvim'

# some ls aliases
alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'


[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh

