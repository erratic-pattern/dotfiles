inputs @ { nixpkgs, ... }:
let
  inherit (builtins) map filter;
in
map (overlay: import overlay inputs)
  (filter (f: f != ./default.nix)
    (nixpkgs.lib.filesystem.listFilesRecursive ./.))

