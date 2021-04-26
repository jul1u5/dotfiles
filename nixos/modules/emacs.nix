{ lib, pkgs, ... }:

let emacsPackage = with pkgs.emacs-pkgs; lib.pipe emacsPgtk [
  emacsPackagesNgGen
  (e: e.emacsWithPackages (p: with p; [
    vterm
    emacsql-sqlite
    pdf-tools
  ]))
];
in
{
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
