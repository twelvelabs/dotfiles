#!/usr/bin/env bash
set -o errexit -o errtrace -o nounset -o pipefail

sudo apt-get update
sudo apt-get install -y rcm
