inputs @ { self, nixpkgs, nixpkgs-stable, ... }:
let
  config = import ./config.nix inputs;
  inherit (nixpkgs.lib) genAttrs mapAttrs;
  inherit (config) androidSystems darwinSystems nixOsSystems systems;
in
rec {
  importNixPkgsCustom = nixpkgs: system: extraArgs: import nixpkgs ({ inherit system; config = config.defaultNixPkgsConfig; } // extraArgs);
  importNixPkgsFor = importNixPkgsCustom nixpkgs;
  importNixPkgsStableFor = importNixPkgsCustom nixpkgs-stable;
  mkApp =
    { system
    , name
    , runtimeInputs ? [ ]
    , script
    , pkgs ? importNixPkgsFor system { }
    , ...
    }:
    let
      programBin = pkgs.writeShellApplication {
        inherit name runtimeInputs;
        text = ''
          export SYSTEM=${system}
          ${script}
        '';
      };
    in
    {
      type = "app";
      program = "${programBin}/bin/${name}";
    };
  mkApps =
    mapAttrs (name: args: mkApp (args // { inherit name; }));

  eachDarwinSystem = genAttrs darwinSystems;
  eachAndroidSystem = genAttrs androidSystems;
  eachNixOsSystem = genAttrs nixOsSystems;
  eachSystem = genAttrs systems;
}
