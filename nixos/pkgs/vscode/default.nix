{ pkgs, ... }:

let
  all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {};
in {
  imports = [
    ./extensions-hack.nix
    (builtins.fetchTarball {
      sha256 = "12riba9dlchk0cvch2biqnikpbq4vs22gls82pr45c3vzc3vmwq9";
      url = "https://github.com/msteen/nixos-vsliveshare/archive/e6ea0b04de290ade028d80d20625a58a3603b8d7.tar.gz";
    })
  ];

  environment.systemPackages = with pkgs; [
    vscode
    (all-hies.unstableFallback.selection { selector = p: { inherit (p) ghc865; }; })
    (import (builtins.fetchTarball "https://github.com/hercules-ci/ghcide-nix/tarball/master") {}).ghcide-ghc865
  ];

  vscode.user = "julius";
  vscode.homeDir = "/home/julius";
  vscode.extensions = with pkgs.vscode-extensions; [
    ms-vscode.cpptools
    ms-python.python
  ];

  services.vsliveshare = {
    enable = true;
    enableWritableWorkaround = true;
    enableDiagnosticsWorkaround = true;
    extensionsDir = "/home/julius/.vscode/extensions";
  };

  # nixpkgs = {
  #   config = {
  #     packageOverrides = pkgs: rec {
  #       vscodePython = pkgs.vscode-with-extensions.override {
  #         vscodeExtensions = vscode-extensions: with vscode-extensions; [
  #           ms-vscode.python
  #         ];
  #       };
  #     };
  #   };
  #   latestPackages = [
  #     "vscode"
  #     "vscode-extensions"
  #   ];
  # };
}