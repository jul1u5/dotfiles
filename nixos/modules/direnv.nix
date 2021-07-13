{ pkgs, ... }:

{
  home.programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
      enableFlakes = true;
    };
  };

  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';
}
