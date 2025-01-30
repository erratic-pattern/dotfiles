inputs @ { nixpkgs, nixpkgs-stable, ... }:
let
  config = import ./config.nix inputs;
  inherit (nixpkgs.lib.attrsets) genAttrs mapAttrs recursiveUpdate;
  inherit (nixpkgs.lib.lists) foldl;
in
rec {
  importNixPkgsCustom = nixpkgs: system: extraArgs: import nixpkgs ({ inherit system; config = config.defaultNixPkgsConfig; } // extraArgs);
  importNixPkgsFor = importNixPkgsCustom nixpkgs;
  importNixPkgsStableFor = importNixPkgsCustom nixpkgs-stable;
  app = args: args // { type = "app"; };
  forAllDarwinSystems = genAttrs config.darwinSystems;
  forAllAndroidSystems = genAttrs config.androidSystems;
  forAllNixOsSystems = genAttrs config.nixOsSystems;
  forAllLinuxSystems = genAttrs config.linuxSystems;
  forAllSystems = genAttrs config.systems;
  mergeAttrList = foldl recursiveUpdate { };
}
