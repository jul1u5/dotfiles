{ inputs, lib, pkgs, ... }:

let
  inherit (lib) makeExtensible attrValues foldr;
  inherit (modules) mapDir;

  modules = import ./modules.nix { inherit lib; };

  lib' = makeExtensible (self: with self;
    let go = file: import file { inherit lib pkgs inputs; };
    in mapDir go ./.
  );
in
lib'.extend (final: prev:
  foldr (a: b: a // b) { } (attrValues prev)
)
