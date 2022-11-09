{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "kvlibadwaita";
  version = "4f52b42d84fda1cc06a340eea89468fee25f3c6e";

  src = fetchFromGitHub {
    owner = "GabePoel";
    repo = "KvLibadwaita";
    rev = version;
    sha256 = "sha256-hzqK+HASboMKCne7XjZfMEE9shZdK7Z01fTQwCU/YU0=";
  };

  installPhase = ''
    mkdir -p $out/share/Kvantum
    cp -r src/KvLibadwaita $out/share/Kvantum
  '';

  meta = with lib; {
    description = "Libadwaita style theme for Kvantum. Based on Colloid-kde.";
    homepage = "https://github.com/GabePoel/KvLibadwaita";
    license = licenses.gpl3;
    maintainers = [ ];
    platforms = platforms.all;
  };
}
