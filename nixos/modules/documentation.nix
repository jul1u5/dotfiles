{ pkgs, ... }:
{
  documentation.dev.enable = true;

  user.packages = with pkgs; [ manpages ];
}
