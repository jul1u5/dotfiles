_:

let
  firefox = "firefox.desktop";

  ranger = "ranger.desktop";
  nautilus = "org.gnome.Nautilus.desktop";
  pcmanfm = "pcmanfm.desktop";
  file-roller = "org.gnome.FileRoller.desktop";
  bottles = "com.usebottles.bottles.desktop";

  evince = "org.gnome.Evince.desktop";
  zathura = "org.pwmt.zathura.desktop";
  xournalpp = "com.github.xournalpp.xournalpp.desktop";

  gimp = "gimp.desktop";
  gthumb = "org.gnome.gThumb.desktop";
  imv = "imv.desktop";
  mpv = "mpv.desktop";

  code = "code.desktop";
  nvim = "nvim.desktop";

  gsconnect = "org.gnome.Shell.Extensions.GSConnect.desktop";
  transmission = "userapp-transmission-gtk-7K8P90.desktop";

  associations = {
    "application/pdf" = [ evince zathura firefox xournalpp ];
    "application/postscript" = [ evince zathura ];

    "application/xhtml+xml" = firefox;
    "application/x-xpinstall" = firefox; # Web Extension installation file

    "application/zip" = file-roller;
    "application/x-tar" = file-roller;

    "application/x-shellscript" = nvim;

    "application/x-ms-dos-executable" = bottles;

    "image/gif" = [ gthumb imv gimp ];
    "image/jpeg" = [ gthumb imv gimp ];
    "image/png" = [ gthumb imv gimp ];
    "image/svg+xml" = [ gthumb imv gimp];

    "video/mp4" = mpv;
    "video/x-matroska" = mpv;

    "inode/directory" = [ nautilus pcmanfm ranger ];
    "inode/mount-point" = [ nautilus pcmanfm ranger ];
    "inode/x-empty" = nvim;

    "text/html" = firefox;

    "text/css" = nvim;
    "text/csv" = nvim;
    "text/plain" = nvim;
    "text/x-csrc" = nvim;
    "text/x-plain" = nvim;
    "text/x-tex" = code;

    "x-scheme-handler/http" = firefox;
    "x-scheme-handler/https" = firefox;
    "x-scheme-handler/about" = firefox;
    "x-scheme-handler/unknown" = firefox;
    "x-scheme-handler/mailto" = firefox;

    "x-scheme-handler/magnet" = transmission;

    "x-scheme-handler/sms" = gsconnect;
    "x-scheme-handler/tel" = gsconnect;
  };
in
{
  home._ = {
    xdg.mimeApps = {
      enable = true;
      associations.added = associations;
      defaultApplications = associations;
    };
  };
}
