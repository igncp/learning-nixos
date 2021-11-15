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
      nodejs
    ];

  networking.hostName = "nixos-tests";
  networking.interfaces.enp0s3.useDHCP = true;
  networking.useDHCP = false;

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

  time.timeZone = "Europe/Madrid";

  users.extraUsers.igncp = {
    extraGroups = [ "wheel" ];
    home = "/home/igncp";
    isNormalUser = true;
    shell = pkgs.zsh;
  };
}

