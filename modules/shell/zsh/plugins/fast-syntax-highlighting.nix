{ lib, pkgs, ... }:

{
  home._ = {
    programs.zsh = {
      enableSyntaxHighlighting = lib.mkForce false;

      plugins = [
        {
          name = "fast-syntax-highlighting";
          file = "share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh";
          src = pkgs.zsh-fast-syntax-highlighting;
        }
      ];
    };
  };
}
