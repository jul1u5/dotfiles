{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        inherit (pkgs) lib;
        pkgs = import nixpkgs { inherit system; };
      in
      {
        defaultPackage = derivation { };

        devShell = pkgs.mkShell {
          buildInputs = lib.attrValues {
            inherit (pkgs) ${0:`%`};
          };
        };
      }
    );
}
