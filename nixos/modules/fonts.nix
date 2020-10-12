{ pkgs, ... }:

{
  fonts = {
    fonts = with pkgs; [
      corefonts
      dejavu_fonts
      helvetica-neue-lt-std
      jetbrains-mono
      joypixels
      manrope
      (nerdfonts.override {
        fonts = [ "FiraCode" ];
      })
      overpass
      symbola
    ];

    fontconfig = {
      defaultFonts = {
        sansSerif = [ "Overpass" "JoyPixels" ];
        monospace = [ "FiraCode Nerd Font" ];
        emoji = [ "JoyPixels" ];
      };
    };
  };
}
