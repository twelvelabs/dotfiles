#!/usr/bin/env bash
set -o errexit -o errtrace -o nounset -o pipefail

# Install dotfiles
RCRC="./rcm/rcrc" rcup -v
