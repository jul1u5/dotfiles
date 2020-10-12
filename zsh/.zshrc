export PATH="$HOME/.npm-global/bin:$PATH"
export ZSH=~/.oh-my-zsh

if [ ! -d $ZSH ]; then
  git clone https://github.com/robbyrussell/oh-my-zsh.git $ZSH
fi

ZSH_THEME=""
RPROMPT=""

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

set -o emacs

setopt nomenucomplete
# setopt MENU_COMPLETE
setopt autocd
setopt extendedglob

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

CASE_SENSITIVE=true

DISABLE_CORRECTION=true

ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOCONNECT=false

setopt HIST_IGNORE_ALL_DUPS

# unsetopt correct
# setopt correct

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

plugins=(
  autoupdate
  history-substring-search
  nix-shell
  tmux
  zsh-autosuggestions
  zsh-completions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

autoload -Uz compinit

for dump in ~/.zcompdump(N.mh+24); do
  compinit
done

if [ -f ~/.aliases ]; then
  source ~/.aliases
fi

if [ -n "${commands[fzf-share]}" ]; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
fi

export WORDCHARS=""

eval "$(starship init zsh)"

eval "$(direnv hook zsh)"
