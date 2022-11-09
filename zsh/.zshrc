export PATH="$HOME/.npm-global/bin:$HOME/.local/bin:$PATH"
export ZSH=~/.oh-my-zsh

fpath+=~/.zfunc

if [[ ! -d $ZSH ]]; then
  git clone https://github.com/robbyrussell/oh-my-zsh.git $ZSH
fi

if [[ ! -d ~/.zsh-autopair ]]; then
  git clone https://github.com/hlissner/zsh-autopair ~/.zsh-autopair
fi

source ~/.zsh-autopair/autopair.zsh
autopair-init

ZSH_THEME=""
RPROMPT=""

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

set -o emacs

setopt nomenucomplete
setopt autocd
setopt extendedglob

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

CASE_SENSITIVE=true
DISABLE_CORRECTION=true

setopt HIST_IGNORE_ALL_DUPS

WORDCHARS='~!#$%^&*(){}[]<>?+;-'
MOTION_WORDCHARS='~!#$%^&*(){}[]<>?+;-'

''{back,for}ward-word() WORDCHARS=$MOTION_WORDCHARS zle .$WIDGET
zle -N backward-word
zle -N forward-word

bindkey -M emacs \^U backward-kill-line
bindkey -M emacs '^[[3;5~' kill-word
bindkey '^H' backward-kill-word
bindkey '5~' kill-word

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
  compinit -i
done

if [ -n "${commands[fzf-share]}" ]; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
fi

LF_ICONS=$(sed ~/.config/diricons \
            -e '/^[ \t]*#/d'       \
            -e '/^[ \t]*$/d'       \
            -e 's/[ \t]\+/=/g'     \
            -e 's/$/ /')
LF_ICONS=${LF_ICONS//$'\n'/:}
export LF_ICONS

ranger_cd() {
  local temp_file="$(mktemp -t "ranger_cd.XXXXXXXXXX")"
  ranger --choosedir="$temp_file" -- "${@:-$PWD}"

  if [ -f "$temp_file" ]; then
    local chosen_dir="$(cat -- "$temp_file")"
    rm -f -- "$temp_file"

    [ -d "$chosen_dir" ] && [ "$chosen_dir" != "$PWD" ] && cd -- "$chosen_dir"
  fi
}

bindkey -s '^o' 'ranger_cd\n'

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"

source "$(which nix-locate | xargs readlink | xargs dirname)/../etc/profile.d/command-not-found.sh"

if [ -f ~/.aliases.sh ]; then
  source ~/.aliases.sh
fi

