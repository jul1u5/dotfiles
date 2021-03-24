{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "materia-kde-theme";
  version = "20210129";

  src = fetchFromGitHub {
    owner = "PapirusDevelopmentTeam";
    repo = "materia-kde";
    rev = version;
    sha256 = "sha256-llnapuA8i5biYTsBvjV2ODlsTOHjwVC4YX05NoDlsK4=";
  };

  makeFlags = [ "PREFIX=$(out)" ];

  meta = {
    description = "A port of the Materia theme for Plasma";
    homepage = "https://git.io/materia-kde";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.all;
  };
}
