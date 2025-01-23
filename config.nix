{ nixpkgs, ... }:
let
  inherit (nixpkgs.lib) unique;
  inherit (builtins) concatLists;
in
rec {
  defaultUser = "adam";

  defaultNixPkgsConfig = {
    allowUnfree = true;
  };

  darwinSystems = [ "aarch64-darwin" ];

  nixOsSystems = [ ];

  androidSystems = [ ];

  systems = unique (concatLists [
    androidSystems
    darwinSystems
    nixOsSystems
  ]);
}
