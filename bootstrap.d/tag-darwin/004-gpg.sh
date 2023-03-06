#!/usr/bin/env bash
set -o errexit -o errtrace -o nounset -o pipefail

function log() {
    local msg="$1"
    echo "[bootstrap][darwin][gpg] ${msg}"
}

if gpg --list-keys "GitHub" &>/dev/null; then
    log "Found GitHub GPG key."
else
    log "Importing GitHub GPG key."
    curl -fsSL https://github.com/web-flow.gpg | gpg --import
fi
