{ lib, ... }:

{
  # See: https://wiki.archlinux.org/title/XDG_Base_Directory
  home._ = {
    home.sessionVariables = {
      ASPELL_CONF = lib.concatStringsSep "; " [
        "per-conf $XDG_CONFIG_HOME/aspell/aspell.conf"
        "personal $XDG_CONFIG_HOME/aspell/en.pws"
        "repl $XDG_CONFIG_HOME/aspell/en.prepl"
      ];
      CONDARC = "$XDG_CONFIG_HOME/conda/condarc";
      CARGO_HOME = "$XDG_DATA_HOME/cargo";
      GOPATH = "$XDG_DATA_HOME/go";
      GRADLE_USER_HOME = "$XDG_DATA_HOME/gradle";
      # GTK2_RC_FILES = "$XDG_CONFIG_HOME/gtk-2.0/gtkrc";
      XCOMPOSEFILE = "$XDG_CONFIG_HOME/X11/xcompose";
      XCOMPOSECACHE = "$XDG_CACHE_HOME/X11/xcompose";
      OPAMROOT = "$XDG_DATA_HOME/opam";
      OCTAVE_HISTFILE = "$XDG_CACHE_HOME/octave-hsts";
      OCTAVE_SITE_INITFILE = "$XDG_CONFIG_HOME/octave/octaverc";
      PLTUSERHOME = "$XDG_DATA_HOME/racket";
    };
  };
}
