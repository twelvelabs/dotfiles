# YubiKey 5c Setup

It took me forever to figure out how to get my YubiKey configured for resident keys (i.e. your SSH keys live on the YubiKey and never touch your filesystem). These are the notes I took for future reference.

Links

- [Using a Yubikey for SSH on macOS](https://aditsachde.com/posts/yubikey-ssh/)
- [How to Store an SSH Key on a Yubikey](https://xeiaso.net/blog/yubikey-ssh-key-storage)
- [ssh-keygen FIDO_AUTHENTICATOR](https://man.openbsd.org/ssh-keygen.1#FIDO_AUTHENTICATOR)
- [ssh-keygen ALLOWED_SIGNERS](https://man.openbsd.org/ssh-keygen.1#ALLOWED_SIGNERS)
- [How to use FIDO2 USB authenticators with SSH](https://www.stavros.io/posts/u2f-fido2-with-ssh/)

```bash
# The macOS folks build openssh w/ `--disable-security-key`,
# so we have to update it (in addition to installing the YubiKey tools) :/
# See:
# - https://github.com/Yubico/libfido2/issues/464
# - https://github.com/apple-oss-distributions/OpenSSH/pull/1
brew install libfido2 openssh ykman

# Aaaaannd that means we can't use the default ssh-agent launchd config, so we need to swap it out w/ one that's pointing to the homebrew version :/
launchctl disable "user/${UID}/com.openssh.ssh-agent"
mkdir -p ~/Library/LaunchAgents
cat << 'EOF' > ~/Library/LaunchAgents/com.twelvelabs.launchd.ssh_agent.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
    <dict>
        <key>Label</key>
        <string>com.twelvelabs.launchd.ssh_agent</string>
        <key>ProgramArguments</key>
        <array>
            <string>sh</string>
            <string>-c</string>
            <string>/opt/homebrew/bin/ssh-agent -D -a ~/.ssh/agent</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
    </dict>
</plist>
EOF
launchctl load -w ~/Library/LaunchAgents/com.twelvelabs.launchd.ssh_agent.plist

# Aaaaannd it turns out any app that launches on startup (cough... Docker for Mac... cough)
# will be referencing the $SSH_AUTH_SOCK from the default ssh-agent, and setting $SSH_AUTH_SOCK
# in our profile won't get picked up. Sigh.
# To prevent hours of s/suffering/troubleshooting/, symlinking the default socket
# to point to our custom one.
# See:
# - https://github.com/docker/for-mac/issues/4242#issuecomment-822027581
cat << 'EOF' > ~/Library/LaunchAgents/com.twelvelabs.launchd.ssh_auth_sock.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
    <dict>
        <key>Label</key>
        <string>com.twelvelabs.launchd.ssh_auth_sock</string>
        <key>ProgramArguments</key>
        <array>
            <string>sh</string>
            <string>-c</string>
            <string>/bin/ln -sf ~/.ssh/agent $SSH_AUTH_SOCK</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
    </dict>
</plist>
EOF
launchctl load -w ~/Library/LaunchAgents/com.twelvelabs.launchd.ssh_auth_sock.plist

cat << 'EOF' > ~/Library/LaunchAgents/com.twelvelabs.launchd.docker_ssh_auth_sock.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
    <dict>
        <key>Label</key>
        <string>com.twelvelabs.launchd.docker_ssh_auth_sock</string>
        <key>ProgramArguments</key>
        <array>
            <string>docker</string>
            <string>run</string>
            <string>-it</string>
            <string>--privileged</string>
            <string>--pid=host</string>
            <string>debian</string>
            <string>nsenter</string>
            <string>-t 1</string>
            <string>-m</string>
            <string>-u</string>
            <string>-n</string>
            <string>-i</string>
            <string>sh -c</string>
            <string>'chmod o+w /run/host-services/ssh-auth.sock'</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>StartInterval</key>
        <integer>300</integer>
    </dict>
</plist>
EOF
launchctl load -w ~/Library/LaunchAgents/com.twelvelabs.launchd.docker_ssh_auth_sock.plist


# Inspect the YubiKey and make sure FIDO2 is enabled (should be by default).
ykman info
# If not, run this.
ykman config usb --enable FIDO2

# Set a FIDO2 PIN (there isn't one by default).
# A few notes:
# - Despite being called "PIN", it allows alphanumeric chars :shrug:.
# - The YubiKey maintains different PINs for various features,
#   so the FIDO2 PIN is different from any others (GPG, PIV, etc).
# - This is required - `ssh-keygen` won't create a key if the PIN isn't set.
ykman fido access change-pin


# Create a resident key.
ssh-keygen -t ed25519-sk -O resident -O application=ssh:github
# If you want to be prompted for the PIN (in addition to touch) on every use.
# This turns out to be super annoying (though I'm sure very secure) if you're
# using the key for github SSH auth.
# ssh-keygen -t ed25519-sk -O resident -O application=ssh:github -O verify-required

# Confirm that it was added to the YubiKey
ykman fido credentials list

# Configure SSH to use it
cat << EOF >> ~/.ssh/config
Host *
  IgnoreUnknown UseKeychain
  UseKeychain yes
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_ed25519_sk
EOF

# Add it to ssh-agent
ssh-add -K
# Confirm that it's there
ssh-add -L

# Copy the key to the clipboard
pbcopy < ~/.ssh/id_ed25519_sk.pub

# Add that key to GitHub as an authentication key.
# If you're also going to be using it to sign commits,
# then you'll need to add it as a signing key, too (even if the same key).
open https://github.com/settings/ssh/new
# Should now see the key here
curl "https://github.com/twelvelabs.keys"



pub_key=`cat ~/.ssh/id_ed25519_sk.pub`
github_emails="twelvelabs@gmail.com"
echo "${github_emails}" "${pub_key}" > ~/.ssh/allowed_signers


git config --global gpg.format ssh
git config --global commit.gpgsign true
git config --global tag.gpgsign true
git config --global user.signingKey ~/.ssh/id_ed25519_sk
git config --global gpg.ssh.allowedSignersFile ~/.ssh/allowed_signers

```
