{ lib, pkgs, unstable, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      emacs = final.lib.pipe prev.emacs [
        final.emacsPackagesNgGen

        (e: e.emacsWithPackages (p: with p; [
          vterm
          emacsql-sqlite
          pdf-tools
        ]))
      ];
    })
  ];

  fonts.fonts = with pkgs; [ emacs-all-the-icons-fonts ];

  environment.systemPackages = with pkgs; [
    # TODO: wrap emacs with its dependencies
    emacs

    # spell
    (aspellWithDicts (d: with d; [
      en
      en-computers
      en-science
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
  ];
}
