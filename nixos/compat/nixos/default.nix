{ ... }:
let
  default = (import ../.).defaultNix;
  inherit (default) lib;

  hostname = lib.fileContents /etc/hostname;
in
default.nixosConfigurations.${hostname}
