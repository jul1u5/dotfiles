{ pkgs, lib, ... }:

let
  kak-config = {
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
    };
  };

  kak-modules = lib.attrValues {
    clipboard = {
      programs.kakoune = {
        plugins = with pkgs.kakounePlugins; [ kakboard ];

        extraConfig = ''
          hook global WinCreate .* %{ kakboard-enable }
        '';
      };
    };

    active-window = {
      programs.kakoune.plugins = with pkgs.kakounePlugins; [ active-window-kak ];
    };

    fzf = {
      programs.kakoune = {
        plugins = with pkgs.kakounePlugins; [ fzf-kak ];

        extraConfig = ''
          map global user f ': fzf-mode<ret>'
        '';
      };
    };

    lsp = {
      xdg.configFile."kak-lsp/kak-lsp.toml".source = ./kak-lsp.toml;

      programs.kakoune = {
        plugins = with pkgs.kakounePlugins; [ kak-lsp ];

        extraConfig = ''
          eval %sh{kak-lsp --kakoune -s $kak_session}
          lsp-enable

          map global user l %{: enter-user-mode lsp<ret>} -docstring "LSP mode"
        '';
      };
    };

    case = {
      programs.kakoune = {
        plugins = with pkgs.kakounePlugins; [ case-kak ];

        extraConfig = ''
          map global normal '`' ': enter-user-mode case<ret>'
        '';
      };
    };

    vertical-selection = {
      programs.kakoune = {
        plugins = with pkgs.kakounePlugins; [ kakoune-vertical-selection ];

        extraConfig = ''
          map global user v     ': vertical-selection-down<ret>'
          map global user <a-v> ': vertical-selection-up<ret>'
          map global user V     ': vertical-selection-up-and-down<ret>'
        '';
      };
    };
  };
in
{
  home = lib.mkMerge ([kak-config] ++ kak-modules);
}
