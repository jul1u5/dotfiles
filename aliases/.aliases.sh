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
