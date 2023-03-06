#!/usr/bin/env bash
set -o errexit -o errtrace -o nounset -o pipefail

# Bootstrap
./bootstrap.sh

# Install dotfiles
echo "[install] Installing dotfiles."
RCRC="./rcm/rcrc" rcup -v

echo "[install] Done 🎉"
