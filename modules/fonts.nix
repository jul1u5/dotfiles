{
  lib,
  pkgs,
  ...
}: let
  nerdfonts = pkgs.nerdfonts.override {
    fonts = ["FiraCode" "JetBrainsMono" "NerdFontsSymbolsOnly"];
  };
in {
  fonts = {
    fontDir.enable = true;

    packages = lib.attrValues {
      inherit nerdfonts;

      inherit
        (pkgs)
        corefonts
        dejavu_fonts
        helvetica-neue-lt-std
        manrope
        overpass
        noto-fonts
        noto-fonts-cjk
        fira
        julia-mono
        fira-mono
        fira-code-symbols
        mononoki
        symbola
        font-awesome
        twitter-color-emoji
        ;
    };

    fontconfig = {
      defaultFonts = {
        sansSerif = [
          "Overpass"
          "Twitter Color Emoji"
        ];
        monospace = [
          "JetBrainsMono Nerd Font"
          "JuliaMono"
          "FiraCode Nerd Font"
          "Fira Code Symbol"
          "DejaVu Sans Mono"
        ];
        emoji = [
          "Twitter Color Emoji"
        ];
      };

      # XeTeX chokes if fontconfig returns WOFF fonts.
      # See:
      #   - XeTeX issue: https://sourceforge.net/p/xetex/bugs/139/
      #   - fontconfig issue: https://gitlab.freedesktop.org/fontconfig/fontconfig/-/issues/92
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

  user.packages = with pkgs; [
    font-manager
  ];
}
