#!/bin/bash

set -e

rsync \
  -rhv --delete \
  ./home/ \
  learn-nixos-vm:/home/igncp/.config/nixpkgs/

ssh -t igncp@learn-nixos-vm <<'EOL'
home-manager switch
EOL
