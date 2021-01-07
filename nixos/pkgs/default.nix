{
  imports = [
    ./android.nix
    ./applications.nix
    ./cli.nix
    ./direnv.nix
    ./emacs.nix
    ./steam.nix
    ./theme.nix
    ./vscode.nix
    ./zsh.nix
  ];

  nixpkgs.config = { allowUnfree = true; };

  environment = {
    defaultPackages = [];

    variables = {
      BROWSER = "firefox";
    };
  };
}
