{ pkgs, ... }:

{
  fonts = {
    fonts = with pkgs; [
      corefonts
      dejavu_fonts
      fira-code
      helvetica-neue-lt-std
      jetbrains-mono
      joypixels
      symbola
      manrope
      overpass
    ];

    fontconfig = {
      defaultFonts = {
        sansSerif = [ "Overpass" "JoyPixels" ];
        monospace = [ "Fira Code" "Symbola" ];
      };
    };
  };
}
