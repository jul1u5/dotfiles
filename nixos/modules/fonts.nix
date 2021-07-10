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
        sansSerif = [ "Overpass" "JoyPixels" ];
        monospace = [ "JetBrainsMono Nerd Font" "FiraCode Nerd Font" "Fira Code Symbol" "DejaVu Serif" ];
        emoji = [ "Twitter Color Emoji" ];
      };

      # Reject WOFF fonts: "XeTeX chokes if fontconfig returns a WOFF file to them".
      # See https://gitlab.freedesktop.org/fontconfig/fontconfig/-/issues/92
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
