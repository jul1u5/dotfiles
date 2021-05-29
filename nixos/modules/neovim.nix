{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    configure.customRC = ''
      source ~/.config/nvim/init.vim
    '';
  };

  environment.systemPackages = with pkgs; [
    nodejs
    rnix-lsp
  ];
}
