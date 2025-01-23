inputs @ { self, nixpkgs, ... }:
let
  config = import ./config.nix inputs;
  inherit (nixpkgs.lib) genAttrs;
  inherit (config) androidSystems darwinSystems nixOsSystems systems;
in
{
  mkApp = system: name:
    let
      pkgs = import nixpkgs {
        inherit system;
        config = config.defaultNixPkgsConfig;
      };
      programBin = pkgs.writeShellScriptBin name ''
        export SYSTEM=${system}
        exec ${self}/apps/${name} "$@"
      '';
    in
    {
      type = "app";
      program = "${programBin}/bin/${name}";
    };
  eachDarwinSystem = genAttrs darwinSystems;
  eachAndroidSystem = genAttrs androidSystems;
  eachNixOsSystem = genAttrs nixOsSystems;
  eachSystem = genAttrs systems;
}
