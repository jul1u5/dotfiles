{ inputs, system, ... }:

{
  programs.nix-ld.enable = true;

  user.packages = with inputs.nix-alien.packages.${system}; [
    nix-alien
    nix-index-update
  ];
}
