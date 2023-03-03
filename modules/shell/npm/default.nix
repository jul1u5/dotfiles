{
  home._ = home: {
    xdg.configFile."npm/config".source = ./.npmrc;

    home.sessionVariables = with home.config; {
      "NPM_CONFIG_USERCONFIG" = "${xdg.cacheHome}/npm/config";
      "NPM_CONFIG_CACHE" = "${xdg.cacheHome}/npm";
    };
  };
}
