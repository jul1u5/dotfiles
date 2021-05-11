{ pkgs, ... }:

let
  fallout-grub-theme = pkgs.fetchFromGitHub {
    owner = "shvchk";
    repo = "fallout-grub-theme";
    hash = "sha256-r8KGj7IJBXIEi+0ewH3Kakg30iJw+kp8QBIBiEas7tk=";
    rev = "211348f7fe7002a144c709dc3eb5d04f4acde4dd";
  };
in
{
  config = {
    boot = {
      kernelPackages = pkgs.linuxPackages_latest;

      # plymouth.enable = true;

      loader = {
        efi.canTouchEfiVariables = true;

        # systemd-boot = {
        #   enable = true;
        #   consoleMode = "max";
        #   editor = false;
        #   configurationLimit = 5;
        # };

        grub = {
          enable = true;
          device = "nodev";
          efiSupport = true;
          configurationLimit = 5;

          extraConfig = ''
            set theme=($drive1)//themes/fallout-grub-theme/theme.txt
          '';
          splashImage = "${fallout-grub-theme}/background.png";
        };
      };
    };

    system.activationScripts.copyGrubTheme = ''
      mkdir -p /boot/themes
      cp -R ${fallout-grub-theme}/ /boot/themes/fallout-grub-theme
    '';
  };
}
