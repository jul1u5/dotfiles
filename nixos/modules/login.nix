_:

{
  security = {
    pam.services = {
      gdm.enableGnomeKeyring = true;
    };
  };

  services = {
    xserver = {
      enable = true;
      displayManager = {
        # defaultSession = "sway";
      };
    };

    # greetd = {
    #   enable = true;
    #   settings =
    #     let
    #       greeting = lib.escapeShellArg ''"There's always another secret."'';
    #       command = lib.concatStringsSep " " [
    #         "${pkgs.greetd.tuigreet}/bin/tuigreet"
    #         "--time"
    #         "--greeting"
    #         "${greeting}"
    #         "--cmd"
    #         ''"systemd-cat -t sway -- sway --debug"''
    #       ];
    #     in
    #     {
    #       default_session = {
    #         inherit command;
    #         user = "greeter";
    #       };
    #     };
    # };
  };
}
