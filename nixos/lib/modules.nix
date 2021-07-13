{ lib, ... }:

let
  mapAttrs'' = f: set:
    lib.pipe (lib.attrNames set) [
      (map (attr: f attr set.${attr}))
      (lib.filter (x: x != null))
      lib.listToAttrs
    ];
in
rec {
  mapModules = f: dir:
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

  mapModulesRec = f: dir:
    let
      go = file: type:
        let path = "${toString dir}/${file}"; in

        if lib.hasPrefix "_" file
        then null

        else if type == "directory"
        then lib.nameValuePair file (mapModulesRec f path)

        else if
          type == "regular" &&
          file != "default.nix" &&
          lib.hasSuffix ".nix" file
        then lib.nameValuePair (lib.removeSuffix ".nix" file) (f path)

        else null;
    in
    mapAttrs'' go (builtins.readDir dir);

  mapModulesRec' = f: dir:
    let
      files = lib.attrValues (mapModules lib.id dir);
      dirs = lib.pipe (builtins.readDir dir) [
        (lib.filterAttrs (name: type: type == "directory" && !(lib.hasPrefix "_" name)))
        (lib.mapAttrsToList (name: _: "${toString dir}/${name}"))
        (map (mapModulesRec' lib.id))
        lib.concatLists
      ];
    in
    map f (files ++ dirs);
}
