{ pkgs, ... }:

let
  vsliveshare = builtins.fetchTarball
    "https://github.com/msteen/nixos-vsliveshare/tarball/master";
in {
  imports = [ ./extensions-hack.nix vsliveshare ];

  environment.systemPackages = with pkgs; [ vscode-with-extensions ];

  services.vsliveshare = {
    enable = true;
    extensionsDir = "/home/julius/.vscode/extensions";
  };

  vscode.user = "julius";
  vscode.homeDir = "/home/julius";
  vscode.extensions = with pkgs.vscode-extensions; [
    ms-vscode.cpptools
    ms-python.python
  ];
}
