{ stdenv, lib, rustPlatform, fetchFromGitHub, cmake, pkg-config, freetype, expat, makeWrapper, wayland, libX11, libxkbcommon, vulkan-loader }:

rustPlatform.buildRustPackage rec {
  pname = "onagre";
  version = "1.0.0-alpha.0";

  src = fetchFromGitHub {
    owner = "oknozor";
    repo = "onagre";
    rev = version;
    sha256 = "sha256-hP+slfCWgsTgR2ZUjAmqx9f7+DBu3MpSLvaiZhqNK1Q=";
  };

  cargoSha256 = "sha256-IOhAGrAiT2mnScNP7k7XK9CETUr6BjGdQVdEUvTYQT4=";

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    # pop-launcher
    makeWrapper
    freetype
    expat
  ];

  postInstall = ''
    wrapProgram $out/bin/onagre \
      --suffix LD_LIBRARY_PATH : ${lib.makeLibraryPath [ libxkbcommon wayland vulkan-loader libX11 ]}
  '';

  meta = with lib; {
    homepage = "https://github.com/oknozor/onagre";
    description = "General application launcher for X/Wayland";
    license = licenses.mit;
  };
}
