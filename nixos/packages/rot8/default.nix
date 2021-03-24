{ lib, rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  pname = "rot8";
  version = "0.1.3";

  src = fetchFromGitHub {
    owner = "efernau";
    repo = pname;
    rev = "8f2128c172be8ecc3e76e0801534413b301ccbd2";
    sha256 = "tXKf/aGD+BJDJeDmfqZBPcG75rmD+iVvj9QB5g+8Bl0=";
  };

  cargoSha256 = "pYGfuA8SdG1FQEo8QxF0PBeGiydbKOhmu8gRJ8m+c3E=";
}
