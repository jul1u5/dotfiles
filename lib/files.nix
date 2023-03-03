{ lib, ... }:

let
  /* Map over an attribute set, filtering out null values.

    Type:
    mapAttrsMaybe :: (String -> a -> b) -> AttrSet -> AttrSet

    Example:
    mapAttrsMaybe (name: value: if value > 0 then { ${name} = value; } else null) { a = 1; b = -1; }
    => { a = 1; }
  */
  mapAttrsMaybe = f: set:
    lib.pipe (lib.attrNames set) [
      (map (attr: f attr set.${attr}))
      (lib.remove null)
      lib.listToAttrs
    ];

  /* Flatten an attribute set into a single level attribute set.

    Type:
    flattenAttrs :: String -> AttrSet -> AttrSet

    Example:
    flattenAttrs "." { a = { b = 1; c = { d = 2; }; }; }
    => { "a.b" = 1; "a.c.d" = 2; }
  */
  flattenAttrs = sep:
    let
      go = prevPath:
        lib.concatMapAttrs (name: value:
          let
            path = prevPath ++ [ name ];
            pathStr = lib.concatStringsSep sep path;
          in
          if lib.isAttrs value
          then go path value
          else { ${pathStr} = value; }
        );
    in
    go [ ];
in
rec {
  /* Read a directory of Nix modules.

    Type:
    readModules :: String -> AttrSet

    Example:
    Given the following directory structure:
    modules
    ├── a
    │   ├── default.nix
    │   └── hidden.nix
    └── b
        └── c.nix

    readModules ./modules
    => { "a" = ./modules/a; "b-c" = ./modules/b/c.nix; }
  */
  readModules = dir:
    let
      go = basename: type:
        # toString is important here, otherwise nix throws an error
        # > error: access to path '/nix/store/...' is forbidden in pure eval mode
        let path = "${toString dir}/${basename}"; in

        if lib.hasPrefix "_" basename
        then null

        else if
          type == "regular" &&
          basename != "default.nix" &&
          lib.hasSuffix ".nix" basename
        then lib.nameValuePair (lib.removeSuffix ".nix" basename) path

        else if
          type == "directory"
        then
          lib.nameValuePair basename
            (
              if lib.pathExists "${path}/default.nix"
              then path
              else readModules path
            )

        else null;
    in
    lib.pipe (builtins.readDir dir) [
      (mapAttrsMaybe go)
      (flattenAttrs "-")
    ];

  /* Read a directory of Nix modules and return a list of them. */
  readModulesToList = dir: lib.attrValues (readModules dir);
}
