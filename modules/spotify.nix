{
  inputs,
  pkgs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in {
  # user.packages = with pkgs; [ spotify ];

  home._ = {
    imports = [inputs.spicetify-nix.homeManagerModule];

    programs.spicetify = {
      enable = true;
      theme = spicePkgs.themes.Default // {replaceColors = false;};
      # colorScheme = "flamingo";

      enabledCustomApps = with spicePkgs.apps; [
        new-releases
        reddit
        lyrics-plus
        marketplace
      ];

      enabledExtensions = with spicePkgs.extensions; [
        bookmark
        loopyLoop
        shuffle

        copyToClipboard
        #fullAppDisplayMod
        genre
        history
        lastfm
        playNext
        playlistIcons
        powerBar
        seekSong
        showQueueDuration
        skipOrPlayLikedSongs
        songStats
        wikify
      ];
    };
  };
}
