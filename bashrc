# secrets
[[ -f ~/.secrets/bash.sh ]] && source ~/.secrets/bash.sh
# aliases
[[ -f ~/.aliases ]] && source ~/.aliases


export ARCHFLAGS="-arch x86_64"
export EDITOR='mate -w'
export PS1="[\u@\h:\w] $ "
export GOPATH="$HOME/Projects/golang"
export PATH="$GOPATH/bin:/usr/local/heroku/bin:/usr/local/bin:/usr/local/sbin:$PATH"
export RUBYOPT="-W0"
export TERM_CHILD=1
export NVM_DIR="$HOME/.nvm"

# export SSL_CERT_FILE=/usr/local/etc/openssl/certs/cert.pem
# export CHEF_REPO_PATH=~/Projects/chef-berkshelf

[[ -f /usr/local/etc/bash_completion ]] && source /usr/local/etc/bash_completion
[[ -f "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
[[ -f "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"

[[ -x /usr/local/bin/rbenv ]] && eval "$(rbenv init -)"
[[ -x /usr/local/bin/hub ]] && eval "$(hub alias -s)"

# local config
[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local
