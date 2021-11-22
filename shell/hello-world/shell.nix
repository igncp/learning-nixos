# Run `nix-shell` inside this directory
# https://nix.dev/tutorials/declarative-and-reproducible-developer-environments#customizing-your-developer-environment

{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/3590f02e7d5760e52072c1a729ee2250b5560746.tar.gz") { } }:

pkgs.mkShell {
  buildInputs = [
    pkgs.which
    pkgs.htop
    pkgs.zlib
  ];

  shellHook = ''
    echo hello
  '';

  MY_ENVIRONMENT_VARIABLE = "world";
}
