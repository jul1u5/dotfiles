{ pkgs, ... }:

{
  home._ = home: {
    programs.zsh = {
      # Resolve conflicting shortcuts (like Ctrl-R) with fzf
      # See: https://github.com/jeffreytse/zsh-vi-mode/issues/24#issuecomment-873029329
      localVariables = {
        ZVM_INIT_MODE = "sourcing";
      };

      # Load before fzf to resolve conflicting shortcuts
      initExtraBeforeCompInit = ''
        source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

        # Re-add keybind for partially accepting suggestion from zsh-autosuggestions
        bindkey '^[f' forward-word
      '';
    };
  };
}
