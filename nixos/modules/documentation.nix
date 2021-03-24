{ pkgs, ... }:
{
  documentation.dev.enable = true;

  environment.systemPackages = with pkgs; [ manpages ];
}
