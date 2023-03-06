#!/usr/bin/env bash
set -o errexit -o errtrace -o nounset -o pipefail

./bootstrap.sh

echo "[install] Installing dotfiles."
RCRC="./rcm/rcrc" rcup -v -f

echo "[install] Updating dotfiles Git remote."
git remote set-url origin git@github.com:twelvelabs/dotfiles.git

echo "[install] Done 🎉"
exit 0
