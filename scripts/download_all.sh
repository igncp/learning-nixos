#!/bin/bash

set -e

if [ -n "$(git status --porcelain=v1)" ]; then
  echo "There are unstashed files. Please stash them before running this script."
  exit 1
fi

# backup
rsync \
  -rh \
  --delete \
  ./ \
  /tmp/learning-nixos-backup/

rsync \
  -rh \
  --delete \
  --exclude=.git \
  learn-nixos-vm:/home/igncp/repo/ \
  ./

echo "Downloaded successfully"
