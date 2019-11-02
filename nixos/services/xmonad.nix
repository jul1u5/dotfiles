{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    taffybar
  ];

  services = {
    dbus = {
      socketActivated = true;
      packages = with pkgs; [ gnome3.dconf gnome2.GConf ];
    };

    xserver = {
      windowManager = {
        xmonad = {
          enable = true;
          enableContribAndExtras = true;
          extraPackages = haskellPackages: [
            haskellPackages.xmonad-contrib
            haskellPackages.xmonad-extras
            haskellPackages.xmonad
          ];
        };
      };
    };
  };
}