_:

{
  home._.programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  nix.extraOptions = ''
    keep-outputs = true
  '';
}
