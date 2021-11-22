# https://nixos.org/guides/nix-pills/working-derivation.html#idm140737320294544

# nix-build simple.nix

with (import <nixpkgs> { });
derivation {
  name = "simple";
  builder = "${bash}/bin/bash";
  args = [ ./simple_builder.sh ];
  inherit gcc coreutils;
  src = ./simple.c;
  system = builtins.currentSystem;
}
