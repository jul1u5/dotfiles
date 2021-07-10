{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.laptop;
in
{
  options.modules.laptop = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    services = {
      thermald.enable = true;
      tlp.enable = true;
      upower.enable = true;

      blueman.enable = true;
    };

    programs = {
      light.enable = true;
    };
  };
}
