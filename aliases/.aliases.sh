alias rm='trash-put'
alias cat=bat

alias ls='exa --binary --git --group-directories-first'
alias ll='ls --icons -lgh'
alias la='ll -aa'

alias vim=nvim

alias nix='noglob nix'

alias o='xdg-open'

alias ip='ip -c'

alias nixos-option='nixos-option -I nixpkgs=/etc/current-configuration/compat'

alias nixos-history='nix profile history --profile /nix/var/nix/profiles/system'
alias nixos-diff='nix profile diff-closures --profile /nix/var/nix/profiles/system | less -FR +F'

if [ "$TERM" = "xterm-kitty" ]; then
  alias icat="kitty +icat"
fi

function path() {
  echo ${1:-$PATH} | tr ':' '\n'
}

# Configuring RemoteCommand in .ssh/config breaks rsync
alias tssh='ssh -t -o RemoteCommand="tmux new -As ssh"'

function duplicate-screen() {
  wayvnc -o "${1:-eDP-1}" --render-cursor &
  trap "kill $!" EXIT
  vinagre localhost -f
}

function e() {
  if [ -z "$1" ] || [ -w "$1" ] || [ -w "$(dirname "$1")" ]; then
    $EDITOR -- "$@"
  else
    sudoedit -- "$@"
  fi
}

function fork() {
  ($@ &)
}

function nix-locate-bin() {
  local package=$(nix-locate --top-level --at-root --whole-name "/bin/$1" \
    | fzf -1 \
    | cut -d' ' -f1
  )

  echo "${package%.out}"
}

function nix-locate-man() {
  local package=$(nix-locate --top-level --at-root --whole-name "/share/$1" \
    | fzf -1 \
    | cut -d' ' -f1
  )

  echo "${package%.out}"
}

function ,() {
  echo "nix shell nixpkgs#$(nix-locate-bin $1) -c $@"
}

function list-fonts-with-codepoint() {
  printf '%x' $@ | xargs -I{} fc-list ":charset={}"
}
