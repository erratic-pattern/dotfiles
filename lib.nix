inputs @ { nixpkgs, ... }:
let
  config = import ./config.nix inputs;
  inherit (nixpkgs.lib) genAttrs;
  inherit (config) androidSystems darwinSystems nixOsSystems systems;
in
{
  eachDarwinSystem = genAttrs darwinSystems;
  eachAndroidSystem = genAttrs androidSystems;
  eachNixOsSystem = genAttrs nixOsSystems;
  eachSystem = genAttrs systems;
}
