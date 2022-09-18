export PATH=$PATH:/home/devon/apps/bin
export PATH=$PATH:/home/devon/scripts

export PATH=$PATH:/home/devon/go/bin

export PATH=$PATH:/home/devon/.emacs.d/bin

export PATH=$PATH:/home/devon/.cargo/bin

export DOOMDIR=~/.config/doom

export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools

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

alias el='exa -la'

export EDITOR=/usr/bin/nvim
export CLJ_CONFIG=~/.config/clojure

export ZPLUG_HOME=~/.config/.zplug
source $ZPLUG_HOME/init.zsh

zplug "jeffreytse/zsh-vi-mode"

#zplug "spaceship-prompt/spaceship-prompt", use:spaceship.zsh, from:github, as:theme

# zsh users
zplug "zsh-users/zsh-completions",              defer:0
zplug "zsh-users/zsh-autosuggestions",          defer:2, on:"zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting",      defer:3, on:"zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search", defer:3, on:"zsh-users/zsh-syntax-highlighting"

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

export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init zsh)"
eval "$(zoxide init --cmd j zsh)"
