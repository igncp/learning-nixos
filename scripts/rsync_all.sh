#!/bin/bash

set -e

rsync \
  -rh \
  --delete \
  ./ \
  learn-nixos-vm:/home/igncp/repo/

echo "Copied successfully"
