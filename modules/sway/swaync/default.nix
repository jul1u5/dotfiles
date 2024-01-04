{
  lib,
  pkgs,
  ...
}: {
  home._ = {
    systemd.user.services.swaync = {
      Unit.PartOf = ["sway-session.target"];
      Install.WantedBy = ["sway-session.target"];

      Service = {
        ExecStart = "${pkgs.swaynotificationcenter}/bin/swaync";
        Restart = "on-failure";
        # override default stylesheet and GTK theme
        Environment = "XDG_CONFIG_DIRS=${pkgs.writeTextDir "swaync/style.css" ""}";
      };
    };

    xdg.configFile = {
      "swaync/config.json".text = lib.generators.toJSON {} {
        positionX = "right";
        positionY = "top";
        timeout = 10;
        timeout-low = 5;
        timeout-critical = 0;
        notification-window-width = 480;
        fit-to-screen = true;
        keyboard-shortcuts = true;
        image-visibility = "when-available";
        transition-time = 0;
        hide-on-clear = true;
        hide-on-action = true;
      };
      "swaync/style.css".text =
        # lib.concatStrings (lib.attrsets.mapAttrsToList (k: v: "@define-color ${k} ${v};\n") solarized) +
        builtins.readFile ./style.css;
    };

    # dummy file to create empty theme
    # xdg.dataFile."themes/none/gtk-3.0/gtk.css".text = "";
  };
}
