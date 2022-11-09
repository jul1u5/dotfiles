{ lib, pkgs, ... }:

let
  vscode-with-extensions = pkgs.unstable.vscode-with-extensions.override {
    inherit (pkgs.unstable) vscode;
    vscodeExtensions = with all-vscode-extensions; [
      # Vim
      bodil.file-browser
      pascalsenn.keyboard-quickfix
      stephlin.vscode-tmux-keybinding
      vscodevim.vim
      vspacecode.vspacecode
      vspacecode.whichkey

      # Version Control
      codezombiech.gitignore
      eamodio.gitlens
      github.vscode-pull-request-github
      kahole.magit

      # Tools
      adpyke.codesnap
      editorconfig.editorconfig
      foxundermoon.shell-format
      github.copilot
      github.copilot-labs
      james-yu.latex-workshop
      valentjn.vscode-ltex
      jock.svg
      ms-vscode-remote.remote-containers
      ms-vscode-remote.remote-ssh
      ms-vscode.makefile-tools
      ms-vsliveshare.vsliveshare
      ryu1kn.partial-diff
      # vadimcn.vscode-lldb
      visualstudioexptteam.vscodeintellicode

      # Theme
      pkief.material-icon-theme
      ibm.output-colorizer
      naumovs.color-highlight

      # Misc
      bierner.docs-view
      cardinal90.multi-cursor-case-preserve
      christian-kohler.path-intellisense
      sleistner.vscode-fileutils
      usernamehw.errorlens

      # Assembly
      all-vscode-extensions."13xforever".language-x86-64-assembly

      # Nix
      bbenoist.nix
      jnoortheen.nix-ide
      # arrterian.nix-env-selector

      # Haskell
      haskell.haskell
      justusadam.language-haskell
      phoityne.phoityne-vscode # GHCi Debugger
      visortelle.haskell-spotlight

      # Web
      dbaeumer.vscode-eslint
      esbenp.prettier-vscode
      styled-components.vscode-styled-components
      pflannery.vscode-versionlens
      svelte.svelte-vscode
      firefox-devtools.vscode-firefox-debug
      formulahendry.auto-rename-tag

      # Java
      vscjava.vscode-java-pack
      redhat.java
      vscjava.vscode-maven
      vscjava.vscode-java-debug
      vscjava.vscode-java-test
      vscjava.vscode-java-dependency
      vscjava.vscode-gradle

      # Python
      ms-python.python
      ms-python.vscode-pylance

      # Jupyter
      ms-toolsai.jupyter
      ms-toolsai.jupyter-renderers
      ms-toolsai.jupyter-keymap

      # Julia
      julialang.language-julia

      # Rust
      matklad.rust-analyzer
      serayuzgur.crates

      # C/C++
      ms-vscode.cpptools
      llvm-vs-code-extensions.vscode-clangd
      xaver.clang-format

      # CMake
      twxs.cmake
      ms-vscode.cmake-tools
      cheshirekow.cmake-format

      # C#
      ms-dotnettools.csharp

      # OCaml
      ocamllabs.ocaml-platform

      # Kotlin
      fwcd.kotlin

      # Go
      golang.go

      # Racket
      eugleo.magic-racket

      # Unison
      benfradet.vscode-unison

      # ReScript
      chenglou92.rescript-vscode

      # LBNF (BNFC)
      agurodriguez.vscode-lbnf

      # Lean
      jroesch.lean
      leanprover.lean4

      # Agda
      banacorn.agda-mode

      # Coq
      maximedenes.vscoq

      # TLA+
      alygin.vscode-tlaplus

      # Docker
      ms-azuretools.vscode-docker

      # YAML
      redhat.vscode-yaml

      # TOML
      tamasfe.even-better-toml

      # Penrose
      penrose.penrose-vs

      # XML
      dotjoshjohnson.xml

      # SQL
      mtxr.sqltools

      # Shaders
      slevesque.shader
      raczzalan.webgl-glsl-editor

      # PDF
      tomoki1207.pdf

      # GAP
      feisele86.gap-language-support

      # Bash
      mads-hartmann.bash-ide-vscode

      # Alloy
      arashsahebolamri.alloy
      dongyuzhao.alloy-vscode
    ];
  };

  all-vscode-extensions =
    let
      forceUpdate = [ "magit" ];
      publisherMapping = {
        "evzen-wybitul" = "eugleo";
        "matklad" = "rust-analyzer";
      };

      inherit (pkgs.unstable) vscode-utils vscode-extensions;
      mktplcRefs = (import ./extensions.nix).extensions;

      go = prevExts: mktplcRef:
        let
          nixpkgsPublisher = publisherMapping.${mktplcRef.publisher} or mktplcRef.publisher;
          extPath = map lib.toLower [ nixpkgsPublisher mktplcRef.name ];
          prevExt = lib.attrByPath extPath null prevExts;

          ext =
            if prevExt == null then
            # Create a new extension if it's not in nixpkgs
              vscode-utils.extensionFromVscodeMarketplace mktplcRef
            else if lib.elem mktplcRef.name forceUpdate then
            # Update extensions declared in `forceUpdate`
              prevExt.overrideAttrs
                (_: {
                  name = with mktplcRef; "${nixpkgsPublisher}-${name}-${version}";
                  src = vscode-utils.fetchVsixFromVscodeMarketplace mktplcRef;
                })
            else prevExt;
        in
        lib.pipe ext [
          (lib.setAttrByPath extPath)
          (lib.mapAttrs (_name: lib.recurseIntoAttrs))
          (lib.recursiveUpdate prevExts)
        ];
    in
    lib.foldl' go vscode-extensions mktplcRefs;
in
{
  user.packages = [
    vscode-with-extensions
  ];
}
