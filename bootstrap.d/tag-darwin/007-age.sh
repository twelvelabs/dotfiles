#!/usr/bin/env bash
set -o errexit -o errtrace -o nounset -o pipefail

function log() {
    local msg="$1"
    echo "[bootstrap][darwin][age] ${msg}"
}

log "Generating yubikey identities."
mkdir -p ~/.age
age-plugin-yubikey --identity 2>/dev/null 1>~/.age/yubikey-identity.txt
age-plugin-yubikey --list >~/.age/yubikey-recipients.txt

chmod 700 ~/.age
chmod 600 ~/.age/yubikey-identity.txt
chmod 600 ~/.age/yubikey-recipients.txt

log "Decrypting secrets to home directory."
~/bin/decrypt secrets.age ~/.secrets
