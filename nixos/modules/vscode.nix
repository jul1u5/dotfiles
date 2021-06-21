{ lib, pkgs, ... }:

let
  vscode-with-extensions = pkgs.vscode-with-extensions.override {
    vscode = pkgs.vscode;
    vscodeExtensions = with pkgs.vscode-extensions // my-extensions; [
      # Languages
      bbenoist.Nix
      fwcd.kotlin
      golang.Go
      haskell.haskell
      justusadam.language-haskell
      jnoortheen.nix-ide
      jroesch.lean
      julialang.language-julia
      ms-dotnettools.csharp
      ms-python.python
      ms-python.vscode-pylance
      ms-toolsai.jupyter
      ms-vscode.cpptools
      redhat.vscode-yaml
      tamasfe.even-better-toml
      matklad.rust-analyzer
      ms-azuretools.vscode-docker
      alygin.vscode-tlaplus
      jpoissonnier.vscode-styled-components
      dotjoshjohnson.xml

      # Version Control
      eamodio.gitlens
      github.vscode-pull-request-github

      # Tools
      tomoki1207.pdf
      arrterian.nix-env-selector
      dbaeumer.vscode-eslint
      editorconfig.editorconfig
      esbenp.prettier-vscode
      ms-vsliveshare.vsliveshare
      mtxr.sqltools

      # Enhancements
      bodil.file-browser
      christian-kohler.path-intellisense
      coenraads.bracket-pair-colorizer-2
      ibm.output-colorizer
      kahole.magit
      naumovs.color-highlight
      pascalsenn.keyboard-quickfix
      pflannery.vscode-versionlens
      stephlin.vscode-tmux-keybinding
      tyriar.vscode-terminal-here
      usernamehw.errorlens
      Cardinal90.multi-cursor-case-preserve
      vscodevim.vim
      vspacecode.vspacecode
      vspacecode.whichkey

      # Theme
      pkief.material-icon-theme
    ];
  };

  my-extensions = mkExtensions {
    julialang.language-julia = {
      version = "1.0.10";
      sha256 = "sha256-+tnyHNt5NVb6XqAobnS6C8rLh+3yA7OKeGiL08snrBI=";
    };

    pascalsenn.keyboard-quickfix = {
      version = "0.0.6";
      sha256 = "sha256-BK7ND6gtRVEitxaokJHmQ5rvSOgssVz+s9dktGQnY6M=";
    };

    fwcd.kotlin = {
      version = "0.2.22";
      sha256 = "sha256-CkoAl2hmkrf+hnDQo6CdgWsqUeF6EgeS1Pjabqo7nVk=";
    };

    jroesch.lean = {
      version = "0.16.36";
      sha256 = "sha256-SWbqVXvm6/cjFX+n+A+v0gOxcZ2RdIV/vWkeNQWCX8Y=";
    };

    arrterian.nix-env-selector = {
      version = "1.0.7";
      sha256 = "sha256-DnaIXJ27bcpOrIp1hm7DcrlIzGSjo4RTJ9fD72ukKlc=";
    };

    christian-kohler.path-intellisense = {
      version = "2.3.0";
      sha256 = "sha256-dCxpRvSka2rHR4kI/FCIE1LnDY0i+JwtMTFE9sgc1/M=";
    };

    mtxr.sqltools = {
      version = "0.23.0";
      sha256 = "sha256-Obo/u2shO6UkOG9V6LDOHrLFFapMGSiu8EVoLU8NdT4=";
    };

    pflannery.vscode-versionlens = {
      version = "1.0.9";
      sha256 = "sha256-cPESnrSnCurVUEgPh6g4Tk7PY3K4du6w9pcOZUYf1bM=";
    };

    vspacecode.vspacecode = {
      version = "0.9.1";
      sha256 = "sha256-/qJKYXR0DznqwF7XuJsz+OghIBzdWjm6dAlaRX4wdRU=";
    };

    vspacecode.whichkey = {
      version = "0.8.5";
      sha256 = "sha256-p5fukIfk/tZFQrkf6VuT4fjmeGtKAqHDh6r6ky847ks=";
    };
    bodil.file-browser = {
      version = "0.2.10";
      sha256 = "sha256-RW4vm0Hum9AeN4Rq7MSJOIHnALU0L1tBLKjaRLA2hL8=";
    };

    kahole.magit = {
      version = "0.6.14";
      sha256 = "sha256-F7nj1wjfzgUfjiUGelfRrBEmHnJ2su+I8+7X6PN3d78=";
    };

    github.vscode-pull-request-github = {
      version = "0.26.0";
      sha256 = "sha256-GcTBXSy2h1FcHEn/Ivf1irrWdYuamzX2DCji/Q/22Fo=";
    };

    tyriar.vscode-terminal-here = {
      version = "0.2.4";
      sha256 = "sha256-GZ++N7tASiQ2sN8Ahn68+siN3FHnQUjaVifoE42XlCY=";
    };

    Cardinal90.multi-cursor-case-preserve = {
      version = "1.0.5";
      sha256 = "sha256-eJafjYDydD8DW83VLH9MPFeDENXBx3el7XvjZqu88Jw=";
    };
  };

  mkExtensions = lib.mapAttrs (publisher:
    lib.mapAttrs (name: versionWithHash:
      let mkptplcExtRef = { inherit publisher name; } // versionWithHash; in
      pkgs.vscode-utils.extensionFromVscodeMarketplace mkptplcExtRef
    )
  );
in
{
  environment.systemPackages = [
    vscode-with-extensions
  ];
}
