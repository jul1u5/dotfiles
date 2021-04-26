{ inputs, ... }:
final: prev:

with final;
let
  mkStudio = opts:
    callPackage (import "${inputs.nixpkgs}/pkgs/applications/editors/android-studio/common.nix" opts) {
      fontsConf = makeFontsConf { fontDirectories = [ ]; };
      inherit (gnome2) GConf gnome_vfs;
      inherit buildFHSUserEnv;
    };
in
{
  androidStudioPackages = prev.androidStudioPackages // {
    canary = mkStudio {
      channel = "canary";
      pname = "android-studio-canary";
      version = "2020.3.1.10";
      sha256Hash = "sha256-Ur8LQyOKlbyGCoBQRyg9mJJ/FracNWNYjfYWL6X0vZc=";
    };
  };
}
