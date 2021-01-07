{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ direnv nix-direnv ];

  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';

  environment.pathsToLink = [
    "/share/nix-direnv"
  ];
}
