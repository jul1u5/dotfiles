{ pkgs, ... }:

{
  environment.variables.SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS = "0";

  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    lutris
    legendary-gl
    wineWowPackages.stable
  ];
}
