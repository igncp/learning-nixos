#!/bin/bash

set -e

VM_IP="$1"

rsync \
  -rhv \
  --delete \
  --exclude .git \
  ./ "$VM_IP":/home/igncp/repo
