alias rm='trash-put'
alias cat=bat

alias ls='exa --icons --git --group-directories-first'
alias ll='ls -lgh'
alias la='ll -a'

alias vim=nvim

alias nix='noglob nix'

alias o='xdg-open'

alias ip='ip --color=auto'

if [ "$TERM" = "xterm-kitty" ]; then
    alias icat="kitty +icat"
fi

function e() {
    if [ -w "$1" ] || [ -w "$(dirname "$1")" ]; then
        $EDITOR -- "$@"
    else
        sudoedit -- "$@"
    fi
}

alias nixos-option='nixos-option -I nixpkgs=/etc/nixos/compat -I nixos-config=/etc/nixos/compat/nixos'

function ,() {
    local package=$(
        nix-locate --top-level --at-root --whole-name "/bin/$1" \
            | fzf -1 \
            | awk '{ print $1 }' \
    )

    if [ -n "$package" ]; then
        nix shell "nixpkgs#$package" -c "$@"
    fi
}
