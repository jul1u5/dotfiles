{ pkgs, ... }:

{
  environment.variables = {
    SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS = "0";
  };

  programs = {
    steam.enable = true;
  };

  user.packages = with pkgs; [
    protonup
    lutris
    legendary-gl
    heroic
    # Needed by HeroicBashLauncher
    gnome.zenity

    mangohud
    gamemode

    minecraft
  ];
}
