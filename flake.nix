{
  description = "Nix System Configuration Files";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";


    home-manager = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nix-darwin.follows = "darwin";
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };

    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    homebrew-garden = {
      url = "github:garden-io/homebrew-garden";
      flake = false;
    };

    kubelogin = {
      url = "github:int128/kubelogin";
      flake = false;
    };

    vim-tintin = {
      url = "github:LokiChaos/vim-tintin";
      flake = false;
    };
  };
  outputs =
    inputs @ { self
    , darwin
    , ...
    }:
    let
      config = import ./config.nix inputs;
      lib = import ./lib.nix inputs;
      overlays = import ./overlays inputs;
      inherit (builtins) readFile;
      inherit (lib) eachSystem eachDarwinSystem mkApps importNixPkgsFor importNixPkgsStableFor;
    in
    {
      inherit lib;

      packages = eachSystem
        (system:
          let
            pkgs = importNixPkgsFor system { };
          in
          pkgs.callPackage ./packages inputs
        );

      apps = eachDarwinSystem
        (system:
          mkApps {
            "switch" = {
              inherit system;
              name = "switch";
              runtimeInputs = [ darwin.packages.${system}.darwin-rebuild ];
              script = readFile ./apps/darwin/switch;
            };
          });

      darwinConfigurations =
        let
          darwinConfiguration =
            { user ? config.defaultUser
            , system ? config.defaultDarwinSystem
            , extraOverlays ? [ ]
            , modules ? [ ]
            }:
            let
              pkgs = importNixPkgsFor system {
                overlays = overlays.darwin ++ extraOverlays;
              };
              pkgs-stable = importNixPkgsStableFor system { };
              specialArgs = (inputs // {
                inherit user pkgs-stable;
                flake-inputs = inputs;
              });
            in
            darwin.lib.darwinSystem {
              inherit specialArgs pkgs modules;
            };
        in
        {

          "personal-macbook" = darwinConfiguration {
            modules = [
              ./machines/personal-macbook.nix
            ];
          };
          "influx-macbook" = darwinConfiguration {
            modules = [
              ./machines/influx-macbook.nix
            ];
          };
        };
    };

}

