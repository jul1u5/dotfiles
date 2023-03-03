{ lib, pkgs, ... }:

{
  home._ = home: {
    programs.zsh = {
      enableAutosuggestions = lib.mkForce false;

      plugins = [
        {
          name = "zsh-autocomplete";
          file = "zsh-autocomplete.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "marlonrichert";
            repo = "zsh-autocomplete";
            rev = "22.01.21";
            sha256 = "sha256-+UziTYsjgpiumSulrLojuqHtDrgvuG91+XNiaMD7wIs=";
          };
        }
      ];

      initExtra = ''
        bindkey "key[Up]" up-line-or-search
      '';
    };
  };
}
