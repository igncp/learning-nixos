#!/bin/bash

set -e

VM_IP="$1"

scp \
  ./configuration.nix \
  root@"$VM_IP":/etc/nixos/configuration.nix

ssh -t root@"$VM_IP" <<'EOL'
nixos-rebuild switch
EOL
