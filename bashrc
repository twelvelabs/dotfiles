# secrets
[[ -f ~/.secrets/bash.sh ]] && source ~/.secrets/bash.sh
# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

export EDITOR='code --wait'
export PS1="[\u@\h:\w] $ "
export GOPATH="/usr/local/go"
export PATH="$GOPATH/bin:/usr/local/heroku/bin:/usr/local/bin:/usr/local/sbin:$PATH"
export NVM_DIR="$HOME/.nvm"

[[ -f /usr/local/etc/bash_completion ]] && source /usr/local/etc/bash_completion
[[ -f "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
[[ -f "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"

[[ -x /usr/local/bin/pyenv ]] && eval "$(pyenv init -)"
[[ -x /usr/local/bin/rbenv ]] && eval "$(rbenv init -)"
[[ -x /usr/local/bin/hub ]] && eval "$(hub alias -s)"

# local config
[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local

# added by travis gem
[ -f /Users/sbaney/.travis/travis.sh ] && source /Users/sbaney/.travis/travis.sh
