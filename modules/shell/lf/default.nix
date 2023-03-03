{ pkgs, ... }:

{
  home._ = {
    programs = {
      lf = {
        enable = true;

        keybindings = {
          D = "trash";
          U = "!du -sh";
          gg = null;
          gh = "cd ~";
          i = "$less $f";

          # use enter for shell commands
          "<enter>" = "shell";

          # execute current file (must be executable)
          x = "$$f";
          X = "!$f";

          # dedicated keys for file opener actions
          o = "&mimeopen $f";
          O = "$mimeopen --ask $f";
        };

        previewer = {
          keybinding = "i";
          source = pkgs.writeShellScript "pv.sh" ''
            #!/bin/sh

            case "$1" in
                *.tar*) tar tf "$1";;
                *.zip) unzip -l "$1";;
                *.rar) unrar l "$1";;
                *.7z) 7z l "$1";;
                *.pdf) pdftotext "$1" -;;
                *) highlight -O ansi "$1" || cat "$1";;
            esac
          '';
        };

        commands = {
          get-mime-type = ''%xdg-mime query filetype "$f"'';
          open = "$$OPENER $f";
        };
      };

      dircolors.enable = true;

      zsh.initExtra = ''
        LF_ICONS=$(sed ~/.config/diricons \
          -e '/^[ \t]*#/d' \
          -e '/^[ \t]*$/d' \
          -e 's/[ \t]\+/=/g' \
          -e 's/$/ /')
        LF_ICONS=''${LF_ICONS//$'\n'/:}
        export LF_ICONS
      '';
    };
  };
}
