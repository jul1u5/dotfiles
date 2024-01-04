{pkgs, ...}: let
  emacsPackage = (pkgs.emacsPackagesFor pkgs.emacs29-pgtk).emacsWithPackages (p:
    with p; [
      #vterm
      #emacsql-sqlite
      #pdf-tools
    ]);
in {
  # TODO: wrap emacs with its dependencies
  user.packages =
    [emacsPackage]
    ++ (with pkgs; [
      parinfer-rust

      # spell
      (aspellWithDicts (d:
        with d; [
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
    ]);
}
