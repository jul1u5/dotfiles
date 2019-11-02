{ pkgs, ...}:

{
  fonts = {
    fonts = with pkgs; [
      corefonts
      fira-code
      fira-code-symbols
      font-awesome-ttf
      freefont_ttf
      google-fonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      overpass
    ];

    enableDefaultFonts = true;

    fontconfig = {
      defaultFonts = {
        sansSerif = [ "Overpass" "Noto Color Emoji" ];
        monospace = [ "Fira Code" "Fira Code Symbol" "Noto Sans Mono CJK SC"];
      };
    };
  };
}