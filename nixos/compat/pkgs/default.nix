_:

let
  flake = (import ../.).defaultNix;
  system = builtins.currentSystem;
in
flake.legacyPackages.${system}
