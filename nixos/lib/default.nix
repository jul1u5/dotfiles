{ inputs, lib, pkgs, ... }:

let
  inherit (lib) makeExtensible attrValues foldr;
  inherit (modules) mapModules;

  modules = import ./modules.nix { inherit lib; };

  lib' = makeExtensible (self: with self;
    let go = file: import file { inherit lib pkgs inputs; };
    in mapModules go ./.
  );
in
lib'.extend (final: prev:
  foldr (a: b: a // b) { } (attrValues prev)
)
