{
  lib,
  pkgs,
  ...
}: {
  home._ = {
    programs.vscode = {
      enable = true;
      package = pkgs.unstable.vscode;
      extensions = with pkgs.unstable.vscode-extensions; [
        ms-vsliveshare.vsliveshare
      ];
    };
  };
  user.packages = [
    pkgs.unstable.nixd
    pkgs.unstable.nil
  ];
}
