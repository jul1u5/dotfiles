{ pkgs, ... }:

{
  environment = {
    variables.SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS = "0";
    systemPackages = with pkgs; [ steam ];
  };
}
