#!/usr/bin/env bash
set -o errexit -o errtrace -o nounset -o pipefail

function log() {
    local msg="$1"
    echo "[bootstrap][darwin][openssh] ${msg}"
}

# Apple builds openssh w/ yubikey support disabled, so I'm installing openssh from homebrew.
# Unfortunately that means we can't use the default ssh-agent launchd config,
# so we need to swap it out w/ one that's pointing to the homebrew version.
# See:
# - https://github.com/Yubico/libfido2/issues/464
# - https://github.com/apple-oss-distributions/OpenSSH/pull/1
log "Disabling the default SSH agent."
launchctl disable "user/${UID}/com.openssh.ssh-agent"

mkdir -p ~/Library/LaunchAgents

log "Ensuring homebrew SSH agent enabled."
if [[ ! -f ~/Library/LaunchAgents/com.twelvelabs.ssh_agent.plist ]]; then
    cp bootstrap.d/tag-darwin/LaunchAgents/com.twelvelabs.ssh_agent.plist \
        ~/Library/LaunchAgents/com.twelvelabs.ssh_agent.plist
    launchctl load -w ~/Library/LaunchAgents/com.twelvelabs.ssh_agent.plist
else
    launchctl stop com.twelvelabs.ssh_agent
    launchctl start com.twelvelabs.ssh_agent
fi
# Aaaaannd it turns out any app that launches on startup (cough... Docker for Mac... cough)
# will be referencing the $SSH_AUTH_SOCK from the default ssh-agent, and setting $SSH_AUTH_SOCK
# in our profile won't get picked up. Sigh.
# To prevent hours of s/suffering/troubleshooting/, symlinking the default socket
# to point to our custom one.
# See:
# - https://github.com/docker/for-mac/issues/4242#issuecomment-822027581
if [[ ! -f ~/Library/LaunchAgents/com.twelvelabs.ssh_auth_sock.plist ]]; then
    cp bootstrap.d/tag-darwin/LaunchAgents/com.twelvelabs.ssh_auth_sock.plist \
        ~/Library/LaunchAgents/com.twelvelabs.ssh_auth_sock.plist
    launchctl load -w ~/Library/LaunchAgents/com.twelvelabs.ssh_auth_sock.plist
else
    launchctl stop com.twelvelabs.ssh_auth_sock
    launchctl start com.twelvelabs.ssh_auth_sock
fi
