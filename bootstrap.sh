#!/usr/bin/env bash
set -o errexit -o errtrace -o nounset -o pipefail

echo "[bootstrap] Running default scripts."
for path in bootstrap.d/default/*.sh; do
    if [[ "$path" == "bootstrap.d/default/*.sh" ]]; then
        break # no scripts found
    fi
    echo "$path"
done

platform=$(uname -s | tr '[:upper:]' '[:lower:]')
echo "[bootstrap][${platform}] Running platform scripts."
for path in "bootstrap.d/tag-${platform}/"*.sh; do
    if [[ "$path" == "bootstrap.d/tag-${platform}/*.sh" ]]; then
        break # no scripts found
    fi
    "$path"
done

# Important that this be calculated here, because the platform scripts
# may have updated the hostname.
hostname=$(hostname)
echo "[bootstrap][${hostname}] Running host scripts."
for path in "bootstrap.d/host-${hostname}/"*.sh; do
    if [[ "$path" == "bootstrap.d/host-${hostname}/*.sh" ]]; then
        break # no scripts found
    fi
    echo "$path"
done
