{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;

  environment.systemPackages = with pkgs;
    [
      git
      neovim-nightly
      nodejs
    ];
  environment.variables.EDITOR = "nvim";
  environment.shellAliases = {
    l = null;
    ll = null;
  };

  networking.hostName = "nixos-tests";
  networking.interfaces.enp0s3.useDHCP = true;
  networking.useDHCP = false;

  nixpkgs.overlays = [
    # for neovim-nightly
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  programs.neovim.enable = true;
  programs.neovim.viAlias = true;
  programs.zsh.enable = true;

  services.openssh.enable = true;
  # For easier SSH copying
  services.openssh.permitRootLogin = "yes";
  services.xserver = {
    enable = true;
    autorun = true;
    windowManager = {
      i3.enable = true;
    };
  };

  system.stateVersion = "21.05";

  users.extraUsers.igncp = {
    extraGroups = [ "wheel" ];
    home = "/home/igncp";
    isNormalUser = true;
    shell = pkgs.zsh;
  };
}

