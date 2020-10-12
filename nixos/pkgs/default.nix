{
  imports = [
    ./android.nix
    ./applications.nix
    ./cli.nix
    ./direnv.nix
    ./emacs.nix
    ./firefox.nix
    ./steam.nix
    ./theme.nix
    ./vscode
    ./zsh.nix
  ];

  nixpkgs.config = { allowUnfree = true; };

  environment.variables = {
    BROWSER = "firefox";

    # rofi
    TERMINAL = "alacritty";
  };
}
