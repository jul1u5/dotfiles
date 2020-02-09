{ stdenv, fetchFromGitHub, glib, gettext }:

stdenv.mkDerivation rec {
  pname = "gnome-shell-extension-switchworkspace";
  version = "1";

  src = fetchFromGitHub {
    owner = "sunwxg";
    repo = "gnome-shell-extension-switchworkspace";
    rev = "b86603adca9a76f75154c19b9de2117a7fbf3971";
    sha256 = "0fp92d90x7zmh7yqg5rdpc0fpa471za4kdvpla3273rhl0qimdni";
  };

  nativeBuildInputs = [ glib gettext ];

  installPhase = ''
    mkdir -p $out/share/gnome-shell/extensions
    cp -r * $out/share/gnome-shell/extensions
  '';
}
