inputs@{ nixpkgs, ... }:
let
  config = import ./config.nix inputs;
  inherit (nixpkgs.lib.attrsets) genAttrs recursiveUpdate;
  inherit (nixpkgs.lib.lists) foldl;
in
 {
  importNixPkgs =
    nixpkgs: system: extraArgs:
    import nixpkgs (
      {
        inherit system;
        config = config.defaultNixPkgsConfig;
      }
      // extraArgs
    );
  app = args: args // { type = "app"; };
  forAllDarwinSystems = genAttrs config.darwinSystems;
  forAllAndroidSystems = genAttrs config.androidSystems;
  forAllNixOsSystems = genAttrs config.nixOsSystems;
  forAllLinuxSystems = genAttrs config.linuxSystems;
  forAllSystems = genAttrs config.systems;
  mergeAttrList = foldl recursiveUpdate { };
}
