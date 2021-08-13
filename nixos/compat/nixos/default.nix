{ ... }:

let
  flake = (import ../.).defaultNix;
  inherit (flake) lib;

  hostname = lib.fileContents /etc/hostname;
in
flake.nixosConfigurations.${hostname}
