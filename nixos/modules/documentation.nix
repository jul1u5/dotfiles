{ pkgs, ... }:

{
  documentation = {
    dev.enable = true;

    # Generate cache for `apropos`, `whatis` and `man -k`.
    # See: https://nixos.wiki/wiki/Apropos
    man.generateCaches = true;
  };

  user.packages = with pkgs; [ man-pages ];
}
