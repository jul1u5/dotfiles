{ config, lib, pkgs, ... }:

let
  cfg = config.modules.boot;

  fallout-grub-theme = pkgs.fetchFromGitHub {
    owner = "shvchk";
    repo = "fallout-grub-theme";
    rev = "211348f7fe7002a144c709dc3eb5d04f4acde4dd";
    sha256 = "r8KGj7IJBXIEi+0ewH3Kakg30iJw+kp8QBIBiEas7tk=";
  };

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
      }
      (lib.mkIf (cfg.theme == "fallout") (mkTheme {
        name = "fallout";
        theme = fallout-grub-theme;
      }))
    ];
}
