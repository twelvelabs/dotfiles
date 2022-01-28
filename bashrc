# secrets
[[ -f ~/.secrets/bash.sh ]] && source ~/.secrets/bash.sh
# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

eval "$(/opt/homebrew/bin/brew shellenv)"

export BASH_SILENCE_DEPRECATION_WARNING=1
export EDITOR='code --wait'
export PS1="[\u@\h:\w] $ "
export GOPATH="$HOME/go"
export NVM_DIR="$HOME/.nvm"
export PATH="$GOPATH/bin:$PATH"

export HISTIGNORE="history*:exit"
export HISTSIZE=5000
export HISTFILESIZE=5000
export HISTCONTROL=ignoreboth:erasedups
shopt -s histappend
# Merge history when closing terminal windows
# Via: https://unix.stackexchange.com/a/556267
function historymerge {
    history -n; history -w; history -c; history -r;
}
trap historymerge EXIT
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

[[ -f /usr/local/etc/bash_completion ]] && source /usr/local/etc/bash_completion
[[ -f "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
[[ -f "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
complete -C aws_completer aws

[[ -x /usr/local/bin/pyenv ]] && eval "$(pyenv init -)"
[[ -x /usr/local/bin/pyenv ]] && eval "$(pyenv virtualenv-init -)"
[[ -x /usr/local/bin/rbenv ]] && eval "$(rbenv init -)"

# local config
[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local

# added by travis gem
[ -f /Users/sbaney/.travis/travis.sh ] && source /Users/sbaney/.travis/travis.sh
