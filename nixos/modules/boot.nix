{ pkgs, fallout-grub-theme, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

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
}
