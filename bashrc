# secrets
[[ -f ~/.secrets/bash.sh ]] && source ~/.secrets/bash.sh
# aliases
[[ -f ~/.aliases ]] && source ~/.aliases


export ARCHFLAGS="-arch x86_64"
export EDITOR='mate -w'
export PS1="[\u@\h:\w] $ "
export PATH="/usr/local/heroku/bin:/usr/local/bin:/usr/local/sbin:$PATH"
export RUBYOPT="-W0"

# export SSL_CERT_FILE=/usr/local/etc/openssl/certs/cert.pem
# export CHEF_REPO_PATH=~/Projects/chef-berkshelf

[[ -x /usr/local/bin/rbenv ]] && eval "$(rbenv init -)"
#[[ -x /usr/local/bin/docker-machine ]] && eval "$(docker-machine env default)"

# local config
[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local
