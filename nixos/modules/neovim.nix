{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;

    configure.customRC = ''
      source ~/.config/nvim/init.vim
    '';
  };

  user.packages = with pkgs; [
    nodejs
    rnix-lsp
  ];
}
