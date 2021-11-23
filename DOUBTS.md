## What is the flow when configuring a package in `configuration.nix`?

The configuration is defined in https://github.com/NixOS/nixpkgs

For example, `environment.systemPackages` is defined in: https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/config/system-path.nix . There it defines some required packages, and it uses `pkgs.buildEnv` to construct the system-path option.

`pkgs/top-level/all-packages.nix` is a long file with the list of many packages. There `buildEnv` is defined this way: `callPackage ../build-support/buildenv`. Seems all packages with `pkgs` prefix are defined in this file.

`runCommand` seems defined in `https://github.com/NixOS/nixpkgs/blob/master/pkgs/build-support/trivial-builders.nix`

## Where are the functions under the `lib.` namespace defined?

Seems `lib` is defined here: https://github.com/NixOS/nixpkgs/blob/faf5e8ad8cf2a4b4a09f86b1a6474f1c32479af9/lib/default.nix

## Where are the functions under the `builtins.` namespace defined?
