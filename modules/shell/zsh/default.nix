{ inputs, lib, pkgs, system, ... }:

{
  imports =
    lib.my.readModulesToList ./init
    ++ lib.my.readModulesToList ./plugins;

  users.defaultUserShell = pkgs.zsh;

  # Needed for zsh completion on system-level commands
  # See https://rycee.gitlab.io/home-manager/options.html#opt-programs.zsh.enableCompletion
  # environment.pathsToLink = [ "/share/zsh" ];

  # The above doesn't work, so we use the following instead (enables completion by default):
  programs.zsh.enable = true;

  home._ = home: {
    home.sessionVariables = {
      _ZO_FZF_OPTS =
        let preview = "${pkgs.eza}/bin/eza -RT -L 2 --icons {2..} | head -200";
        in "$FZF_DEFAULT_OPTS --no-sort --reverse -1 -0 --preview ${lib.escapeShellArg preview}";
    };

    programs = {
      zsh = {
        enable = true;

        dotDir = ".config/zsh";
        history.path = "${home.config.xdg.dataHome}/zsh/zsh_history";

        defaultKeymap = "emacs";

        oh-my-zsh.enable = true;

        enableAutosuggestions = true;
        enableVteIntegration = true;
        historySubstringSearch.enable = true;

        shellAliases = {
          cat = "bat";

          ls = "eza --binary --git --group-directories-first";
          ll = "ls --icons -lgh";
          la = "ll -aa";

          rm = "trash-put";

          ip = "ip -c";
          vim = "nvim";
          o = "xdg-open";

          # Configuring RemoteCommand in .ssh/config breaks rsync
          tssh = "ssh -t -o RemoteCommand='tmux new -As ssh'";

          nix = "noglob nix";
          nixos-history = "nix profile history --profile /nix/var/nix/profiles/system";
          nixos-diff = "nix profile diff-closures --profile /nix/var/nix/profiles/system | less -FR +F";
        };

        initExtra = lib.fileContents ./init.sh;
      };

      eza.enable = true;
      bat.enable = true;
      zoxide.enable = true;
      starship.enable = true;

      fzf = {
        enable = true;

        defaultCommand = "fd --type f";
        defaultOptions = [
          "--height 40%"
          "--prompt ⟫"
        ];

        changeDirWidgetCommand = "fd --type d";
        changeDirWidgetOptions = [
          "--preview 'tree -C {} | head -200'"
        ];
      };
    };
  };
}
