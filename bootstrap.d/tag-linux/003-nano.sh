#!/usr/bin/env bash
set -o errexit -o errtrace -o nounset -o pipefail

# Symlink nano files to a consistent location so that our
# .nanorc file can be the same cross-platform.
sudo mkdir -p /usr/local/share
sudo rm -f /usr/local/share/nano
sudo ln -s /usr/share/nano /usr/local/share/nano
