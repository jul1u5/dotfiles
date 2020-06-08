{
  imports = [
    ./vscode
    ./applications.nix
    ./android.nix
    ./core.nix
    ./direnv.nix
    ./firefox.nix
    ./misc.nix
    ./theme.nix
    ./zsh.nix
  ];

  nixpkgs.config = { allowUnfree = true; };

  environment.variables = {
    BROWSER = "firefox";

    # rofi
    TERMINAL = "alacritty";
  };
}
