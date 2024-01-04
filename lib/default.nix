{
  inputs,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) makeExtensible attrValues foldr;
  inherit (files) readModules;

  files = import ./files.nix {inherit lib;};

  lib' = makeExtensible (
    self: let
      go = file:
        import file {
          inherit lib pkgs inputs;
        };
    in
      lib.mapAttrs (_name: go) (readModules ./.)
  );
in
  lib'.extend (
    final: prev:
      foldr (a: b: a // b) {} (attrValues prev)
  )
