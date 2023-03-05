#!/usr/bin/env bash

# secrets
[[ -f ~/.secrets/bash.sh ]] && source ~/.secrets/bash.sh
# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# `brew shellenv` outputs the following:
#
# export HOMEBREW_PREFIX="/opt/homebrew";
# export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
# export HOMEBREW_REPOSITORY="/opt/homebrew";
# export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
# export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
# export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
eval "$(/opt/homebrew/bin/brew shellenv)"

export BASH_SILENCE_DEPRECATION_WARNING=1
export CLICOLOR=1
export EDITOR='code --wait'
export PS1="[\u@\h:\w] $ "
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$HOME/bin:$PATH"

export HISTIGNORE="history*:exit"
export HISTSIZE=5000
export HISTFILESIZE=5000
export HISTCONTROL=ignoreboth:erasedups
shopt -s histappend
# Merge history when closing terminal windows
# Via: https://unix.stackexchange.com/a/556267
function historymerge {
    history -n
    history -w
    history -c
    history -r
}
trap historymerge EXIT
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

[[ -f "/opt/homebrew/etc/bash_completion" ]] && source "/opt/homebrew/etc/bash_completion"

if [[ -x "/opt/homebrew/bin/pyenv" ]]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
fi

# local config
[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local
