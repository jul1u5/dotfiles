{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball
      "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz"))
  ];

  environment.systemPackages = with pkgs; [
    ((emacsPackagesNgGen emacsUnstable).emacsWithPackages (p: with p; [
      vterm
    ]))
  ];
}
