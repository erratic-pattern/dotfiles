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
    , nixpkgs
    , nixpkgs-stable
    , ...
    }:
    let
      config = import ./config.nix inputs;
      lib = import ./lib.nix inputs;
      inherit (lib) eachDarwinSystem;
    in
    {
      inherit lib;

      apps =
        let
          darwinApps = eachDarwinSystem
            (system: {
              "switch" = {
                type = "app";
                program = "${self}/apps/darwin/switch";
              };
            });
        in
        darwinApps;

      darwinConfigurations =
        let
          darwinConfiguration =
            { user ? config.defaultUser
            , system ? "aarch64-darwin"
            , extraOverlays ? [ ]
            , modules
            }:
            let
              overlays = (import ./overlays inputs).common ++ extraOverlays;
              pkgs = import nixpkgs {
                inherit system overlays;
                config = config.defaultNixPkgsConfig;
              };
              pkgs-stable = import nixpkgs-stable {
                inherit system overlays;
                config = config.defaultNixPkgsConfig;
              };
              specialArgs = (inputs // {
                inherit user system pkgs-stable;
                flake-inputs = inputs;
              });
            in
            darwin.lib.darwinSystem {
              inherit system specialArgs pkgs modules;
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

