# dotfiles

## New machine setup

* Login to iCloud
* Login to App Store
    * Download 1Password and login
* Download [VS Code](https://code.visualstudio.com)
* Login to [GitHub](https://github.com)
* Setup SSH:

```bash
# Generate SSH key
ssh-keygen -t ed25519 -C "twelvelabs@gmail.com"

# Configure SSH
cat > ~/.ssh/config <<EOL
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
EOL
chmod 600 ~/.ssh/config

# Add the key to the SSH agent
eval "$(ssh-agent -s)"
ssh-add -K ~/.ssh/id_ed25519

# Upload the public key to GitHub
pbcopy < ~/.ssh/id_ed25519.pub
open https://github.com/settings/keys
```

* Setup Homebrew:

```bash
# Download Command Line Tools
xcode-select --install

# Install homebrew
open https://brew.sh
```

* Install the dotfiles:

```bash
git clone git@github.com:twelvelabs/dotfiles.git .dotfiles
cd .dotfiles
make install
```