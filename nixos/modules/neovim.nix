{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    configure.customRC = ''
      source ~/.config/nvim/init.vim
    '';
  };

  user.packages = with pkgs; [
    nodejs
    rnix-lsp
  ];
}
