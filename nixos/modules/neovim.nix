{
  programs.neovim = {
    enable = true;
    
    configure.customRC = ''
      source ~/.config/nvim/init.vim
    '';
  };
}
