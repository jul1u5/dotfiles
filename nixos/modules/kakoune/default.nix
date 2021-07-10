{ pkgs, lib, ... }:

{
  home = {
    programs.kakoune = {
      enable = true;

      config = {
        colorScheme = "gruvbox";

        numberLines = {
          enable = true;
          relative = true;
        };

        showWhitespace = {
          enable = true;
          lineFeed = null;
        };

        ui = {
          enableMouse = true;
          assistant = "none";
        };
      };

      plugins = with pkgs.kakounePlugins; [
        kakboard
        fzf-kak
        active-window-kak

        kak-lsp

        case-kak
        kakoune-vertical-selection
      ];

      extraConfig = lib.concatStringsSep "\n" [
        # lsp
        ''
          eval %sh{kak-lsp --kakoune -s $kak_session}
          lsp-enable

          map global user l %{: enter-user-mode lsp<ret>} -docstring "LSP mode"
        ''
        # case
        ''
          map global normal '`' ': enter-user-mode case<ret>'
        ''
        # vertical-selection
        ''
          map global user v     ': vertical-selection-down<ret>'
          map global user <a-v> ': vertical-selection-up<ret>'
          map global user V     ': vertical-selection-up-and-down<ret>'
        ''
      ];
    };

    xdg.configFile."kak-lsp/kak-lsp.toml".source = ./kak-lsp.toml;
  };
}
