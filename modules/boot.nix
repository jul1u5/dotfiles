{ config, lib, pkgs, inputs, ... }:

let
  cfg = config.modules.boot;

  mkTheme = { name, theme }: {
    boot.loader.grub = {
      splashImage = "${theme}/background.png";
      extraConfig = ''
        set theme=($drive1)//themes/${name}/theme.txt
      '';
    };

    system.activationScripts.copyGrubTheme = ''
      mkdir -p /boot/themes
      cp -R ${theme} /boot/themes/${name}
    '';
  };
in
{
  options = {
    modules.boot = {
      theme = lib.mkOption {
        default = null;
        type = with lib.types; nullOr (enum [ "fallout" ]);
      };
    };
  };

  config = lib.mkMerge
    [
      {
        boot = {
          kernelPackages = pkgs.linuxPackages_latest;

          loader = {
            timeout = 1;
            efi.canTouchEfiVariables = true;

            grub = {
              enable = true;
              device = "nodev";
              efiSupport = true;
              configurationLimit = 2;
            };
          };
        };

        # Speed up boot
        systemd.services = {
          systemd-udev-settle.enable = false;
          NetworkManager-wait-online.enable = false;
        };
      }
      (lib.mkIf (cfg.theme == "fallout") (mkTheme {
        name = "fallout";
        theme = inputs.fallout-grub-theme;
      }))
    ];
}
