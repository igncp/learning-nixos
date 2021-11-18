{
  get_home_pkgs = pkgs: with pkgs; [
    fzf
    htop
    jq
    lsof
    moreutils # vidir
    ncdu
    neofetch
    oh-my-zsh
    ranger
    # scc
    tree
    unzip
    zip
    zsh
  ];

  zsh_plugins = [
    {
      name = "zsh-syntax-highlighting";
      file = "zsh-syntax-highlighting.plugin.zsh";
      src = builtins.fetchGit {
        url = "https://github.com/zsh-users/zsh-syntax-highlighting";
        rev = "c7caf57ca805abd54f11f756fda6395dd4187f8a";
      };
    }
    {
      name = "zsh-autopair";
      file = "zsh-autopair.plugin.zsh";
      src = builtins.fetchGit {
        url = "https://github.com/hlissner/zsh-autopair";
        rev = "9d003fc02dbaa6db06e6b12e8c271398478e0b5d";
      };
    }
  ];
}
