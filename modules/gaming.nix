{pkgs, ...}: {
  boot.kernel.sysctl = {
    # Borrowed from Steam Deck and Fedora
    "vm.max_map_count" = 2147483642; # MAX_INT - 5
  };

  environment.variables = {
    # SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS = "0";
  };

  programs = {
    steam.enable = true;
    gamemode.enable = true;
  };

  user.packages = with pkgs; [
    lutris
    legendary-gl
    unstable.heroic
    # Needed by HeroicBashLauncher
    gnome.zenity

    mangohud
    gamescope

    minecraft
  ];
}
