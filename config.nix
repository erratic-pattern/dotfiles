{ nixpkgs, ... }:
let
  inherit (nixpkgs.lib) unique;
  inherit (builtins) concatLists;
in
rec {
  defaultUser = "adam";

  defaultNixPkgsConfig = {
    allowUnfree = true;
    # cudaSupport = true;
    # cudaCapabilities = ["8.0"];
    allowBroken = true;
    # allowInsecure = false;
    allowUnsupportedSystem = true;
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
