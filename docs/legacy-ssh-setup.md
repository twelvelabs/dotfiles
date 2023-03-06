# Legacy SSH Setup

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
