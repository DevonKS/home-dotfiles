export PATH=$PATH:/home/devon/apps/bin
export PATH=$PATH:/home/devon/scripts

export GOPATH=$HOME/development/go
export PATH=$PATH:$GOPATH/bin

export PATH=$PATH:/home/devon/apps/platform-tools
export PATH=$PATH:/home/devon/.emacs.d/bin

export DOOMDIR=~/.config/doom

# Load Git completion
zstyle ':completion:*:*:git:*' script ~/.config/zsh/git-completion.bash
fpath=(~/.config/zsh $fpath)

autoload -Uz compinit && compinit

alias vi='nvim'
alias vim='nvim'

# some ls aliases
alias ll='ls -alhF --color'
alias la='ls -A --color'
alias l='ls -CF --color'
alias sc='source ~/.config/zsh/.zshrc'

export EDITOR=/usr/bin/nvim
export CLJ_CONFIG=~/.config/clojure

export ZPLUG_HOME=~/.config/.zplug
source $ZPLUG_HOME/init.zsh

zplug "jeffreytse/zsh-vi-mode"

zplug "spaceship-prompt/spaceship-prompt", use:spaceship.zsh, from:github, as:theme

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

export ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
zvm_after_init_commands+=('[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh')

export SPACESHIP_TIME_SHOW=true
