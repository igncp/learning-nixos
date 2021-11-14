{ config, pkgs, ... }:

{
  home.username = "igncp";
  home.homeDirectory = "/home/igncp";
  home.stateVersion = "21.05";
  home.file.".inputrc".source = ./.inputrc;
  home.file.".zshrc".text = builtins.readFile ./.zshrc;
  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    EDITOR = "nvim";
  };
  home.packages = [
    pkgs.fzf
    pkgs.htop
    pkgs.jq
    pkgs.zsh
    pkgs.neovim
    pkgs.oh-my-zsh
    # pkgs.zsh-git-prompt # https://github.com/NixOS/nixpkgs/blob/master/pkgs/shells/zsh/zsh-git-prompt/default.nix
  ];
  programs.home-manager.enable = true;

  # https://github.com/nix-community/home-manager/blob/master/modules/programs/zsh.nix
  programs.zsh.enable = true;
  programs.zsh.shellAliases = {};

  # TODO: find a way to source oh-my-zsh manually to avoid unwanted aliases
  programs.zsh.oh-my-zsh.enable = true;
}

