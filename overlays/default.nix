inputs @ { nixpkgs, ... }:
let
  inherit (builtins) readDir map attrNames pathExists;
  inherit (nixpkgs.lib.attrsets) concatMapAttrs filterAttrs;
  inherit (nixpkgs.lib.strings) removeSuffix;
  importDir = dir: 
    if pathExists dir
    then map (overlay: import (dir + "/${overlay}") inputs) (attrNames (filterAttrs (name: type: name != "default.nix" && type == "regular") (readDir dir)))
    else [];
in {
  common = importDir ./common;
  android = importDir ./android;
  darwin = importDir ./darwin;
  nixOs = importDir ./nixOs;
}
