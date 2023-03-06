#!/usr/bin/env bash
set -o errexit -o errtrace -o nounset -o pipefail

function log() {
    local msg="$1"
    echo "[bootstrap][darwin][homebrew] ${msg}"
}

if xcode-select --print-path 1>/dev/null; then
    log "Found command line developer tools."
else
    log "Installing command line developer tools."
    xcode-select --install
fi

if command -v brew &>/dev/null; then
    log "Found homebrew."
else
    log "Installing homebrew."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

log "Brew update."
brew update

if command -v mas &>/dev/null; then
    log "Found mac app store CLI."
else
    log "Installing mac app store CLI."
    brew install mas
fi

log "Brew bundle install."
brew bundle install
