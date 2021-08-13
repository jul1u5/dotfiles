{ lib, pkgs, ... }:

let
  nerdfonts = pkgs.nerdfonts.override {
    fonts = [ "FiraCode" "JetBrainsMono" ];
  };
in
{
  fonts = {
    fonts = lib.attrValues {
      inherit nerdfonts;

      inherit (pkgs)
        corefonts
        dejavu_fonts
        helvetica-neue-lt-std

        manrope
        overpass
        symbola

        fira-code-symbols

        twitter-color-emoji
        ;
    };

    fontconfig = {
      defaultFonts = {
        sansSerif = [
          "Overpass"
          "JoyPixels"
        ];
        monospace = [
          "JetBrainsMono Nerd Font"
          "FiraCode Nerd Font"
          "Fira Code Symbol"
          "DejaVu Serif"
        ];
        emoji = [
          "Twitter Color Emoji"
        ];
      };

      # XeTeX chokes if fontconfig returns WOFF fonts.
      # See:
      #   - XeTeX issue https://sourceforge.net/p/xetex/bugs/139/
      #   - fontconfig issue https://gitlab.freedesktop.org/fontconfig/fontconfig/-/issues/92
      localConf = ''
        <fontconfig>
          <selectfont>
            <rejectfont>
              <glob>*.woff</glob>
            </rejectfont>
          </selectfont>
        </fontconfig>
      '';
    };
  };
}
