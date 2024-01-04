{
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  openssl,
}: let
  src = fetchFromGitHub {
    owner = "antonWetzel";
    repo = "typst-languagetool";
    rev = "045aac788bce931a34eacd95ab93955a6823e53a";
    hash = "sha256-jC2rA85YPe7z3bPdhM68OHdUdDRRCeA3wkGpRbIZgUY=";
  };
in
  rustPlatform.buildRustPackage rec {
    pname = "typst-lt";
    version = "0.1.0";

    inherit src;

    cargoLock = {
      lockFile = "${src}/Cargo.lock";
      allowBuiltinFetchGit = true;
    };

    nativeBuildInputs = [
      pkg-config
    ];

    buildInputs = [
      openssl
    ];
  }
