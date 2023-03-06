# dotfiles

## New machine setup

* Login to iCloud
* Login to App Store
* Run:

```bash
git clone https://github.com/twelvelabs/dotfiles.git .dotfiles
cd .dotfiles

./install.sh
```

* Plugin YubiKey
* Run:

```bash
# Add resident key "references" to `~/.ssh`.
cd ~/.ssh
ssh-keygen -K
# Add them to ssh-agent
ssh-add -K
# Confirm that it's there
ssh-add -L
```
