inputs @ { nixpkgs, ... }:
let
  inherit (builtins) readDir map attrNames pathExists;
  inherit (nixpkgs.lib.attrsets) filterAttrs;
  importDir = dir: 
    if pathExists dir
    then map (overlay: import (dir + "/${overlay}") inputs) (attrNames (filterAttrs (name: type: name != "default.nix" && type == "regular") (readDir dir)))
    else [];
in rec {
  common = importDir ./common;
  android = common ++ importDir ./android;
  darwin = common ++ importDir ./darwin;
  nixOs = common ++ importDir ./nixOs;
}
