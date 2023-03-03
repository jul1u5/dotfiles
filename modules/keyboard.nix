{ lib, pkgs, ... }:
{
  services = {
    xserver = {
      layout = lib.concatStringsSep "," [ "us" "lt" ];
      xkbOptions = lib.concatStringsSep "," [
        "ctrl:nocaps"
        "grp:switch" # Switch layout with Right Alt (while pressed)
        "grp:alt_space_toggle"
        "compose:rctrl"
      ];
    };

    udev.packages = with pkgs; [
      qmk-udev-rules
    ];
  };

  console.useXkbConfig = true;
}
