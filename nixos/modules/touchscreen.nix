{ pkgs, ... }:

{
  user.packages = with pkgs; [
    xournalpp
  ];

  home._ = {
    # FIXME: causing weird issues with wofi on sway.
    # When typing in wofi on a physical keyboard, squeekboard starts appearing and immediately disappears.
    # Something is calling busctl SetVisible true

    # systemd.user.services.squeekboard = {
    #   Unit = {
    #     Description = "On-screen keyboard for Wayland";
    #     PartOf = [ "graphical-session.target" ];
    #   };
    #   Service = {
    #     ExecStart = "${pkgs.squeekboard}/bin/squeekboard";
    #     Restart = "on-failure";
    #   };
    #   Install = {
    #     WantedBy = [ "sway-session.target" ];
    #   };
    # };
  };
}
