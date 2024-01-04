{
  lib,
  pkgs,
  ...
}: {
  i18n.inputMethod = {
    # enabled = "fcitx5";
    # package = lib.mkForce pkgs.unstable.fcitx5-with-addons;
    # ibus.engines = with pkgs.ibus-engines; [
    #   typing-booster
    #   uniemoji
    # ];
  };
}
