# Disable shebang check
# shellcheck disable=SC2148

export PATH="$HOME/.local/bin:$HOME/.cabal/bin:$PATH"

function fork() {
	("$@" &)
}

if [ "$TERM" = "xterm-kitty" ]; then
	alias icat="kitty +icat"
fi

function path() {
	echo "${1:-$PATH}" | tr ':' '\n'
}

function duplicate-screen() {
	wayvnc -o "${1:-eDP-1}" --render-cursor &
	trap 'kill $!' EXIT
	swaymsg 'focus output up'
	vinagre localhost
}

function e() {
	if [ "$1" = "" ] || [ -w "$1" ] || [ -w "$(dirname "$1")" ]; then
		"$EDITOR" -- "$@"
	else
		sudoedit -- "$@"
	fi
}

function nix-locate-bin() {
	local package
	package=$(
		nix-locate --top-level --at-root --whole-name "/bin/$1" |
			fzf -1 |
			cut -d' ' -f1
	)

	echo "${package%.out}"
}

function nix-locate-man() {
	local package
	package=$(
		nix-locate --top-level --at-root --whole-name "/share/$1" |
			fzf -1 |
			cut -d' ' -f1
	)

	echo "${package%.out}"
}

function ,() {
	echo "nix shell nixpkgs#$(nix-locate-bin "$1") -c $*"
}

function list-fonts-with-codepoint() {
	printf '%x' "$1" | xargs -I{} fc-list ":charset={}"
}

ranger_cd() {
	local choosedir_file
	choosedir_file="$(mktemp --suffix ".ranger_cd")"
	ranger --choosedir="$choosedir_file" -- "${*:-$PWD}"

	local chosen_dir
	chosen_dir="$(cat -- "$choosedir_file")"
	rm -f -- "$choosedir_file"

	[ -d "$chosen_dir" ] && [ "$chosen_dir" != "$PWD" ] && cd -- "$chosen_dir" || return
}

bindkey -s '^o' 'ranger_cd\n'

export WORDCHARS='~!#$%^&*(){}[]<>?+;-'
export MOTION_WORDCHARS='~!#$%^&*(){}[]<>?+;-'

''{back,for}ward-word() WORDCHARS=$MOTION_WORDCHARS zle ."$WIDGET"
zle -N backward-word
zle -N forward-word

bindkey '^[.' insert-last-word

bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# zstyle ':autocomplete:tab:*' widget-style menu-select

# load module for list-style selection
# zmodload zsh/complist

# use the module above for autocomplete selection
# zstyle ':completion:*' menu yes select

# now we can define keybindings for complist module
# you want to trigger search on autocomplete items
# so we'll bind some key to trigger history-incremental-search-forward function
# bindkey -M menuselect '/' history-incremental-search-forward
