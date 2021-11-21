# To find the plugins location:
# - Entry point is: ~/.config/nvim/init.vim
#   - Sets the packpath and runtimepath to an specific store id for `vim-packager`
#   - In that directory, it has simlinks to the store ids of each plugin
{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    extraConfig = builtins.readFile ./.vimrc;
    plugins = [
      (pkgs.vimUtils.buildVimPlugin {
        pname = "coc-nvim";
        version = "v0.80";

        src = pkgs.fetchFromGitHub {
          owner = "neoclide";
          repo = "coc.nvim";
          rev = "v0.0.80";
          sha256 = "1c2spdx4jvv7j52f37lxk64m3rx7003whjnra3y1c7m2d7ljs6rb";
        };
      })
      (pkgs.vimUtils.buildVimPlugin rec {
        pname = "auto-pairs";
        version = "v2.0.0";

        src = pkgs.fetchFromGitHub {
          owner = "jiangmiao";
          repo = "auto-pairs";
          rev = version;
          sha256 = "ASK4CWWIhD1C6dwHFpMrUUXlwGrUyJrZmCIyy3LVuV8=";
        };
      })
    ];
  };
}
