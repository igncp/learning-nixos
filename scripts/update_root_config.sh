#!/bin/bash

set -e

scp \
  ./configuration.nix \
  root@learn-nixos-vm:/etc/nixos/configuration.nix

ssh -t root@learn-nixos-vm <<'EOL'
nixos-rebuild switch
EOL
