{ pkgs, ... }:

{
  services = {
    printing = {
      enable = true;
      drivers = [ pkgs.epson-escpr ];
    };

    avahi = {
      enable = true;
      nssmdns = true;
    };
  };
}
