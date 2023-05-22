#!/usr/bin/env bash
set -o errexit -o errtrace -o nounset -o pipefail

function log() {
    local msg="$1"
    echo "[bootstrap][linux][packages] ${msg}"
}

function install-alpine() {
    local dependency="$1"

    if "$(apk list --installed --quiet "${dependency}")" != ""; then
        log "Found dependency: ${dependency}"
    else
        if [[ "${updated}" != "true" ]]; then
            log "Updating package index"
            $sudo apk update
            updated="true"
        fi
        log "Installing dependency: ${dependency}"
        $sudo apk add --no-cache "${dependency}"
    fi
}

function install-deb() {
    local dependency="$1"

    if dpkg -l "${dependency}" &>/dev/null; then
        log "Found dependency: ${dependency}"
    else
        if [[ "${updated}" != "true" ]]; then
            log "Updating package index"
            $sudo apt-get update
            updated="true"
        fi
        log "Installing dependency: ${dependency}"
        $sudo apt-get install -y "${dependency}"
    fi
}

sudo=""
if [[ "$(whoami)" != "root" ]]; then
    sudo="sudo"
fi

updated=""
dependencies=(
    "gum"
    "jq"
    "nano"
    "rcm"
)
for dependency in "${dependencies[@]}"; do
    if command -v apk &>/dev/null; then
        install-alpine "$dependency"
    elif command -v dpkg &>/dev/null; then
        install-deb "$dependency"
    else
        log "Unknown platform!"
        exit 1
    fi
done
