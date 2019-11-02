{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox
  ];

  environment.variables = {
    # Touch screen in firefox
    MOZ_USE_XINPUT2 = "1";
  };
}