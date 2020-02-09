{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    zsh
    oh-my-zsh
  ];

  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;

    ohMyZsh.plugins = with pkgs; [
      zsh-completions
      zsh-history-substring-search
      fzf-zsh
    ];

    promptInit = "";
    interactiveShellInit = ''
      export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh/

      # Customize your oh-my-zsh options here
      ZSH_THEME="robbyrussell"
      plugins=(git docker bgnotify)

      bindkey '\e[5~' history-beginning-search-backward
      bindkey '\e[6~' history-beginning-search-forward

      HISTFILESIZE=500000
      HISTSIZE=500000
      setopt SHARE_HISTORY
      setopt HIST_IGNORE_ALL_DUPS
      setopt HIST_IGNORE_DUPS
      setopt INC_APPEND_HISTORY
      autoload -U compinit && compinit
      unsetopt menu_complete
      setopt completealiases

      if [ -f ~/.aliases ]; then
        source ~/.aliases
      fi

      source $ZSH/oh-my-zsh.sh
    '';
  };
}
