{ pkgs ? import <nixpkgs> { } }:
let
  inherit (pkgs) lib;
in
pkgs.mkShell {
  buildInputs = lib.attrValues {
    inherit (pkgs) ${0:`%`};
  };
}
