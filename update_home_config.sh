#!/bin/bash

set -e

VM_IP="$1"

rsync \
  -rhv --delete \
  ./home/ \
  igncp@"$VM_IP":/home/igncp/.config/nixpkgs/

ssh -t igncp@"$VM_IP" <<'EOL'
home-manager switch
EOL
