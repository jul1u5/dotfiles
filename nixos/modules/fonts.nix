{ pkgs, ... }:

{
  # nixpkgs.config.joypixels.acceptLicense = true;

  fonts = {
    fonts = with pkgs; [
      corefonts
      dejavu_fonts
      helvetica-neue-lt-std
      # jetbrains-mono
      joypixels
      manrope
      (nerdfonts.override {
        fonts = [ "FiraCode" "JetBrainsMono" ];
      })
      fira-code-symbols
      overpass
      symbola
    ];

    fontconfig = {
      defaultFonts = {
        sansSerif = [ "Overpass" "JoyPixels" ];
        monospace = [ "JetBrainsMono Nerd Font" "FiraCode Nerd Font" "Fira Code Symbol" "DejaVu Serif" ];
        emoji = [ "JoyPixels" ];
      };
    };
  };
}
