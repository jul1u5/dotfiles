{
  imports = [
    ./vscode
    ./android.nix
    ./core.nix
    ./direnv.nix
    ./firefox.nix
    ./lorri.nix
    ./misc.nix
    ./theme.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.variables = {
    BROWSER = "firefox";

    # rofi
    TERMINAL = "alacritty";
  };
}