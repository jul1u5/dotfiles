{ lib, ... }:

let
  mapAttrs'' = f: set:
    lib.pipe (lib.attrNames set) [
      (map (attr: f attr set.${attr}))
      (lib.remove null)
      lib.listToAttrs
    ];
in
rec {
  mkLink = src: dest: ''
    [ -L "${dest}" ] && $DRY_RUN_CMD rm $VERBOSE_ARG "${dest}"
    $DRY_RUN_CMD ln -sf $VERBOSE_ARG "${src}" "${dest}"
  '';

  mkCopy = src: dest: ''
    [ -e "${dest}" ] && $DRY_RUN_CMD rm -rf $VERBOSE_ARG "${dest}"
    $DRY_RUN_CMD install -D $VERBOSE_ARG "${src}" "${dest}"
  '';

  mapDir = f: dir:
    let
      go = file: type:
        let path = "${toString dir}/${file}"; in

        if lib.hasPrefix "_" file
        then null

        else if
          type == "directory" &&
          lib.pathExists "${path}/default.nix"
        then lib.nameValuePair file (f path)

        else if
          type == "regular" &&
          file != "default.nix" &&
          lib.hasSuffix ".nix" file
        then lib.nameValuePair (lib.removeSuffix ".nix" file) (f path)

        else null;
    in
    mapAttrs'' go (builtins.readDir dir);
}
