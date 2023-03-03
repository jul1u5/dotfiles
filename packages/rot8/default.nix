{ lib, rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  pname = "rot8";
  version = "0.1.4";

  src = fetchFromGitHub {
    owner = "efernau";
    repo = pname;
    rev = "b7b42d95a99996215ae31bddcd70af3c34c165f6";
    sha256 = "sha256-2644dUyrc/tv/lxhXmldZlgImI2J1zoqUSjXxzFCpWo=";
  };

  cargoSha256 = "sha256-qSzSU5FrMMR/SeLuBByvYAANfVw8dM6pV6HZFOLIRnI=";
}
