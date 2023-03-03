#!/usr/bin/env bash
# Adapted from https://github.com/bennofs/nix-index/blob/master/command-not-found.sh

command_not_found_handle() {
  echo -n "searching nix-index..."
  local -r attrs=$(@nix-locate@ --minimal --no-group --type x --type s --top-level --whole-name --at-root "/bin/$1")

  case $(echo -n "$attrs" | grep -c "^") in
  0)
    echo >&2 -ne "$(@tput@ el1)\r"
    echo >&2 "$1: command not found"
    ;;
  *)
    echo >&2 -ne "$(@tput@ el1)\r"
    echo >&2 "The program ‘$(@tput@ setaf 2)$1$(@tput@ sgr0)’ is currently not installed."
    echo >&2 "It is provided by the following derivation(s):"
    while read -r pkg; do
      local pkg=${pkg%.out}

      local pkgMetaJson=$(@nix@ eval --impure --json --expr "
          let
            find-pkg = registry:
              let
                pkgs = import (builtins.getFlake registry) {};
                inherit (pkgs) lib;
                attrPath = lib.splitString \".\" \"$pkg\";
                pkg = lib.getAttrFromPath attrPath pkgs;
              in
                if ! lib.hasAttrByPath attrPath pkgs
                then null
                else {
                  registry = registry;
                  version = lib.getVersion pkg;
                  desc = pkg.meta.description or null;
                  url = pkg.meta.homepage or null;
                };
            registries = [ \"nixpkgs\" \"unstable\" ];
          in
            builtins.head
              (builtins.filter (x: x != null)
                (builtins.map find-pkg registries))
          ")

      # Convert JSON to Bash associative array
      local -A pkgMeta
      while IFS=';' read -r key value; do
        pkgMeta[$key]="$value"
      done <<<"$(echo -n "$pkgMetaJson" | @jq@ -r 'to_entries[] | if .value == null then empty else "\(.key);\(.value)" end')"

      echo >&2 -n "  $(@tput@ setaf 4)${pkgMeta[registry]}#$(@tput@ setaf 12)$pkg$(@tput@ setaf 8)@${pkgMeta[version]}$(@tput@ sgr0)"
      [[ -v pkgMeta[desc] ]] && echo >&2 -n " - ${pkgMeta[desc]}"
      [[ -v pkgMeta[url] ]] && echo >&2 " (${pkgMeta[url]})" || echo >&2 ""
    done <<<"$attrs"
    ;;
  esac

  return 127
}

command_not_found_handler() {
  command_not_found_handle "$@"
  return $?
}
