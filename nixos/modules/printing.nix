{ pkgs, ... }:

{
  services = {
    printing = {
      enable = true;
      drivers = [ pkgs.my.epson-201401w ];
    };
  };
}
