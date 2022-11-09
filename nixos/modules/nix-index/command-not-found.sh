# Adapted from https://github.com/bennofs/nix-index/blob/master/command-not-found.sh

command_not_found_handle () {
    if [ -n "${MC_SID-}" ] || ! [ -t 1 ]; then
        >&2 echo "$1: command not found"
        return 127
    fi

    echo -n "searching nix-index..."
    ATTRS=$(@nix-locate@ --minimal --no-group --type x --type s --top-level --whole-name --at-root "/bin/$1")

    case `echo -n "$ATTRS" | grep -c "^"` in
        0)
            >&2 echo -ne "$(@tput@ el1)\r"
            >&2 echo "$1: command not found"
            ;;
        *)
            >&2 echo -ne "$(@tput@ el1)\r"
            >&2 echo "The program ‘$(@tput@ setaf 2)$1$(@tput@ sgr0)’ is currently not installed."
            >&2 echo "It is provided by the following derivation(s):"
            while read ATTR; do
                ATTR=$(echo "$ATTR" | sed 's|\.out$||') # Strip trailing '.out'

                META=$(@nix@ eval "nixpkgs#$ATTR.meta" --json)
                # '.version' does not always exist, e.g., 'llvmPackages_8.binutils-unwrapped'.
                # So, we need to extract the version from the name (which is also in '.meta' attribute).
                VERSION=$(echo -E "$META" | @jq@ -r '.name' | awk -F- '{print $NF}')
                DESC=$(echo -E "$META" | @jq@ -r '.description // empty')
                URL=$(echo -E "$META" | @jq@ -r '.homepage // empty')

                >&2 echo -n "  $(@tput@ setaf 4)nixpkgs#$(@tput@ setaf 12)$ATTR$(@tput@ setaf 8)@$VERSION$(@tput@ sgr0)"
                [ -n "$DESC" ] && >&2 echo -n " - $DESC"
                [ -n "$URL"  ] && >&2 echo " ($URL)" || >&2 echo ""
            done <<< "$ATTRS"
    esac

    return 127
}

command_not_found_handler () {
    command_not_found_handle $@
    return $?
}
