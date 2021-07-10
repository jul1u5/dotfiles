{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (_: prev: {
      nix-direnv = prev.nix-direnv.override { enableFlakes = true; };
    })
  ];

  environment.systemPackages = with pkgs; [ direnv nix-direnv ];

  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';

  environment.pathsToLink = [
    "/share/nix-direnv"
  ];
}
