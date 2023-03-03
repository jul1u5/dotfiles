{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;

    configure.customRC = ''
      luafile ~/.config/nvim/init.lua
    '';
  };

  user.packages = with pkgs; [
    nodejs
    rnix-lsp
  ];
}
