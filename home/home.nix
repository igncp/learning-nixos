{ config, pkgs, ... }:
let
  personal_config = import ./config.nix;
in
{
  imports = [
    ./nvim.nix
  ];
  home.username = "igncp";
  home.homeDirectory = "/home/igncp";
  home.stateVersion = "21.05";

  home.file.".inputrc".source = ./.inputrc;
  home.file.".zshrc".text = builtins.readFile ./.zshrc;

  # Avoid loading the /etc/zshrc file.
  home.file.".zshenv".text = ''
    setopt no_global_rcs
  '';

  home.packages = with pkgs; [
    fzf
    htop
    jq
    lsof
    moreutils # vidir
    ncdu
    neofetch
    oh-my-zsh
    ranger
    tree
    unzip
    zip
    zsh
    (callPackage ./git-ftp.nix { })
  ];

  programs.home-manager.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
  };

  # https://github.com/nix-community/home-manager/blob/master/modules/programs/zsh.nix
  programs.zsh.enable = true;
  programs.zsh.shellAliases = {
    l = "less";
    n = "nvim";
  };

  programs.zsh.plugins = personal_config.zsh_plugins;
  programs.zsh.oh-my-zsh.enable = false;

  programs.git.enable = true;
  programs.git.includes = [{ path = ./gitconfig; }];

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
  };

  programs.rofi.enable = true;

  # xdg.enable = true;
  # xdg.configFile."i3/config".text = builtins.readFile ./i3;
  # xsession.windowManager.i3.enable = true;

  programs.alacritty = {
    enable = true;
    settings = {
      font.size = 18;
    };
  };
}

