{ lib, pkgs, ... }:

let emacsPackage = lib.pipe pkgs.emacsPgtkGcc [
  pkgs.emacsPackagesNgGen

  (e: e.emacsWithPackages (p: with p; [
    vterm
    emacsql-sqlite
    pdf-tools
  ]))
];
in
{
  nixpkgs.overlays = [
    (final: prev: with final; {
      mu = prev.mu.overrideAttrs (_: rec {
        version = "1.4.15";

        src = fetchFromGitHub {
          owner = "djcb";
          repo = "mu";
          rev = version;
          sha256 = "sha256-VIUA0W+AmEbvGWatv4maBGILvUTGhBgO3iQtjIc3vG8=";
        };
      });
    })
  ];

  services.emacs = {
    enable = true;
    package = emacsPackage;
  };

  fonts.fonts = with pkgs; [ emacs-all-the-icons-fonts ];

  environment.systemPackages = with pkgs; [
    # TODO: wrap emacs with its dependencies
    emacsPackage

    parinfer-rust

    # spell
    (aspellWithDicts (d: with d; [
      en
      en-computers
      en-science
      lt
    ]))

    # grammar
    # languagetool
    # jre

    # lookup
    ripgrep
    sqlite
    wordnet

    # mu4e
    mu
    isync
    html2text

    # pdf-tools
    poppler
    texlive.combined.scheme-basic
  ];
}
