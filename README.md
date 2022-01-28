Install
-------

Install homebrew:

    open https://brew.sh

Install the dotfiles:

    git clone git@github.com:twelvelabs/dotfiles.git .dotfiles
    cd .dotfiles
    brew bundle install
    rcup -x "README.md Brewfile Brewfile.lock.json"
