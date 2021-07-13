alias rm='trash-put'
alias cat=bat

alias ls='exa --binary --icons --git --group-directories-first'
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

alias nixos-option='nixos-option -I nixpkgs=/etc/current-configuration/compat'

alias nixos-diff='nix profile diff-closures --profile /nix/var/nix/profiles/system | cat --pager="less -FR +G"'

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
