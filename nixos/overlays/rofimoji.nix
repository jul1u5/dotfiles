final: prev:

{
  rofimoji = prev.rofimoji.overridePythonAttrs (old: rec {
    version = "5.1.0";
    src = final.fetchFromGitHub {
      owner = "fdw";
      repo = "rofimoji";
      rev = version;
      sha256 = "sha256-bLV0hYDjVH11euvNHUHZFcCVywuceRljkCqyX4aANVs=";
    };
  });
}
