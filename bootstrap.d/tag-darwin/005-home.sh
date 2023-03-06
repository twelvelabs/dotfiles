#!/usr/bin/env bash
set -o errexit -o errtrace -o nounset -o pipefail

mkdir -p \
    ~/.cache \
    ~/.config \
    ~/.local \
    ~/.ssh \
    ~/bin \
    ~/go \
    ~/src \
    ~/src/gostamp \
    ~/src/twelvelabs

chmod 700 \
    ~/.ssh \
    ~/bin \
    ~/go \
    ~/src
