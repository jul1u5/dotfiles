{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (pkgs.callPackage ../packages/materia-kde { })
    plata-theme
    materia-theme
    paper-icon-theme
    papirus-icon-theme
  ];
}
