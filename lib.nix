{ nixpkgs, ... }:
let
  inherit (nixpkgs) lib;
  inherit (lib.attrsets) genAttrs recursiveUpdate;
  inherit (lib.lists) foldl;

in
rec {

  # default home user for system configurations
  defaultUser = "adam";

  # use a function from system string -> attrset to build an attrset that
  # contains an entry for each system
  forAllSystems = genAttrs lib.platforms.all;

  # recursively merge a list of attrsets
  mergeAttrList = foldl recursiveUpdate { };

  # shorthand to make flake apps
  app = args: args // { type = "app"; };

  # default configuration when importing nixpkgs
  defaultNixPkgsConfig = {
    allowUnfree = true;
    # cudaSupport = true;
    # cudaCapabilities = ["8.0"];
    allowBroken = true;
    allowInsecure = false;
    allowUnsupportedSystem = true;
  };

  # import nixpkgs from the given nixpkgs flake, for the given system, with the
  # default config plus any extra options provided
  importNixPkgs =
    nixpkgs: system: extraArgs:
    import nixpkgs (
      {
        inherit system;
        config = defaultNixPkgsConfig;
      }
      // extraArgs
    );

}
