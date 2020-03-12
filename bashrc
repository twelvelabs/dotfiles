# secrets
[[ -f ~/.secrets/bash.sh ]] && source ~/.secrets/bash.sh
# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

export EDITOR='code --wait'
export PS1="[\u@\h:\w] $ "
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:/usr/local/heroku/bin:/usr/local/bin:/usr/local/sbin:$PATH"
export NVM_DIR="$HOME/.nvm"

export OKTA_USERNAME="skip.baney"

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
[[ -x /usr/local/bin/hub ]] && eval "$(hub alias -s)"

# local config
[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local

# added by travis gem
[ -f /Users/sbaney/.travis/travis.sh ] && source /Users/sbaney/.travis/travis.sh
