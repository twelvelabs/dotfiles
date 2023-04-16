#!/usr/bin/env bash
set -o errexit -o errtrace -o nounset -o pipefail

function log() {
    local msg="$1"
    echo "[bootstrap][linux][packages] ${msg}"
}

updated=""
dependencies=(
    "rcm"
)
for dependency in "${dependencies[@]}"; do
    if dpkg -l "${dependency}" &>/dev/null; then
        log "Found dependency: ${dependency}"
    else
        if [[ "${updated}" != "true" ]]; then
            log "Updating package index"
            sudo apt-get update
            updated="true"
        fi
        log "Installing dependency: ${dependency}"
        sudo apt-get install -y "${dependency}"
    fi
done
