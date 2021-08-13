{ lib, pkgs, ... }:

let
  vscode-with-extensions = pkgs.vscode-with-extensions.override {
    vscode = pkgs.vscode;
    vscodeExtensions = with vscode-extensions; [
      # Vim
      bodil.file-browser
      pascalsenn.keyboard-quickfix
      stephlin.vscode-tmux-keybinding
      vscodevim.vim
      vspacecode.vspacecode
      vspacecode.whichkey

      # Version Control
      eamodio.gitlens
      github.vscode-pull-request-github
      kahole.magit

      # Tools
      editorconfig.editorconfig
      github.copilot
      ms-vscode-remote.remote-containers
      ms-vscode-remote.remote-ssh
      ms-vsliveshare.vsliveshare

      # Theme
      pkief.material-icon-theme
      coenraads.bracket-pair-colorizer-2
      ibm.output-colorizer
      naumovs.color-highlight

      # Misc
      cardinal90.multi-cursor-case-preserve
      christian-kohler.path-intellisense
      sleistner.vscode-fileutils
      usernamehw.errorlens

      # Nix
      bbenoist.Nix
      jnoortheen.nix-ide
      arrterian.nix-env-selector

      # Haskell
      haskell.haskell
      justusadam.language-haskell

      # Web
      dbaeumer.vscode-eslint
      esbenp.prettier-vscode
      jpoissonnier.vscode-styled-components
      pflannery.vscode-versionlens

      # Python
      ms-python.python
      ms-python.vscode-pylance
      ms-toolsai.jupyter

      # Julia
      julialang.language-julia

      # Rust
      matklad.rust-analyzer

      # C++
      ms-vscode.cpptools

      # C#
      ms-dotnettools.csharp

      # Kotlin
      fwcd.kotlin

      # Go
      golang.Go

      # Unison
      benfradet.vscode-unison

      # Lean
      jroesch.lean

      # TLA+
      alygin.vscode-tlaplus

      # Docker
      ms-azuretools.vscode-docker

      # YAML
      redhat.vscode-yaml

      # TOML
      tamasfe.even-better-toml

      # XML
      dotjoshjohnson.xml

      # SQL
      mtxr.sqltools

      # PDF
      tomoki1207.pdf
    ];
  };

  vscode-extensions = overrideExtensions pkgs.vscode-extensions {
    julialang.language-julia = {
      version = "1.0.10";
      sha256 = "+tnyHNt5NVb6XqAobnS6C8rLh+3yA7OKeGiL08snrBI=";
    };

    pascalsenn.keyboard-quickfix = {
      version = "0.0.6";
      sha256 = "BK7ND6gtRVEitxaokJHmQ5rvSOgssVz+s9dktGQnY6M=";
    };

    fwcd.kotlin = {
      version = "0.2.22";
      sha256 = "CkoAl2hmkrf+hnDQo6CdgWsqUeF6EgeS1Pjabqo7nVk=";
    };

    jroesch.lean = {
      version = "0.16.39";
      sha256 = "s27bYJvtRTLO1dgJTYIHxxqsDHVgEJodNfh80WsGPGw=";
    };

    arrterian.nix-env-selector = {
      version = "1.0.7";
      sha256 = "DnaIXJ27bcpOrIp1hm7DcrlIzGSjo4RTJ9fD72ukKlc=";
    };

    christian-kohler.path-intellisense = {
      version = "2.3.0";
      sha256 = "dCxpRvSka2rHR4kI/FCIE1LnDY0i+JwtMTFE9sgc1/M=";
    };

    mtxr.sqltools = {
      version = "0.23.0";
      sha256 = "Obo/u2shO6UkOG9V6LDOHrLFFapMGSiu8EVoLU8NdT4=";
    };

    pflannery.vscode-versionlens = {
      version = "1.0.9";
      sha256 = "cPESnrSnCurVUEgPh6g4Tk7PY3K4du6w9pcOZUYf1bM=";
    };

    vspacecode.vspacecode = {
      version = "0.9.1";
      sha256 = "/qJKYXR0DznqwF7XuJsz+OghIBzdWjm6dAlaRX4wdRU=";
    };

    vspacecode.whichkey = {
      version = "0.8.5";
      sha256 = "p5fukIfk/tZFQrkf6VuT4fjmeGtKAqHDh6r6ky847ks=";
    };

    bodil.file-browser = {
      version = "0.2.10";
      sha256 = "RW4vm0Hum9AeN4Rq7MSJOIHnALU0L1tBLKjaRLA2hL8=";
    };

    kahole.magit = {
      version = "0.6.14";
      sha256 = "F7nj1wjfzgUfjiUGelfRrBEmHnJ2su+I8+7X6PN3d78=";
    };

    github.vscode-pull-request-github = {
      version = "0.26.0";
      sha256 = "GcTBXSy2h1FcHEn/Ivf1irrWdYuamzX2DCji/Q/22Fo=";
    };

    github.copilot = {
      version = "1.2.1991";
      sha256 = "pGb5xfjuy+g646doZEuKhQalkOte5dH+I+1op+vZY48=";
    };

    cardinal90.multi-cursor-case-preserve = {
      version = "1.0.5";
      sha256 = "eJafjYDydD8DW83VLH9MPFeDENXBx3el7XvjZqu88Jw=";
    };

    benfradet.vscode-unison = {
      version = "0.3.0";
      sha256 = "YcpLoRERxOh5ItOryJVxMJFFnOJRjVJOeJDJhijSAPU=";
    };

    sleistner.vscode-fileutils = {
      version = "3.4.5";
      sha256 = "ZzqYt9rkpeKKLhruyK5MQFlBaCZFnv2NYQvBM0YEtjg=";
    };

    ms-vscode-remote.remote-containers = {
      version = "0.190.0";
      sha256 = "8P/i71NgqlSHtnI9sa2TialaGT1+GyaWOE/ZYn8zYyc=";
    };
  };

  overrideExtensions = old: new:
    let
      newExtensions = lib.mapAttrs
        (publisher: namesWithRefs:
          let
            exts = lib.mapAttrs
              (name: versionWithHash:
                let mkptplcExtRef = { inherit publisher name; } // versionWithHash; in
                pkgs.vscode-utils.extensionFromVscodeMarketplace mkptplcExtRef
              )
              namesWithRefs;
          in
          (old.${publisher} or { }) // exts
        )
        new;
    in
    old // newExtensions;
in
{
  user.packages = [
    vscode-with-extensions
  ];
}
