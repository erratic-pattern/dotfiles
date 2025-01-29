inputs @ { self, nixpkgs, nixpkgs-stable, ... }:
let
  config = import ./config.nix inputs;
  inherit (nixpkgs.lib) genAttrs;
  inherit (config) androidSystems darwinSystems nixOsSystems systems;
in
rec {
  importNixPkgsCustom = nixpkgs: system: extraArgs: import nixpkgs ({ inherit system; config = config.defaultNixPkgsConfig; } // extraArgs);
  importNixPkgsFor = importNixPkgsCustom nixpkgs;
  importNixPkgsStableFor = importNixPkgsCustom nixpkgs-stable;
  mkApp = system: name:
    let
      pkgs = importNixPkgsFor system { };

      programBin = pkgs.writeShellScriptBin name ''
        export SYSTEM=${system}
        exec ${self}/apps/${name} "$@"
      '';
    in
    {
      type = "app";
      program = "${programBin}/bin/${name}";
    };
  mkApps = apps: system: genAttrs apps (mkApp system);
  eachDarwinSystem = genAttrs darwinSystems;
  eachAndroidSystem = genAttrs androidSystems;
  eachNixOsSystem = genAttrs nixOsSystems;
  eachSystem = genAttrs systems;
}
