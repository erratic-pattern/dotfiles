{
  description = "Nix System Configuration Files";
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs?rev=d2faa1bbca1b1e4962ce7373c5b0879e5b12cef2";
    };
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
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
    inputs@{
      nixpkgs,
      darwin,
      nix-on-droid,
      ...
    }:
    let
      config = import ./config.nix inputs;
      lib = import ./lib.nix inputs;
      overlays = import ./overlays inputs;
      inherit (lib)
        app
        forAllSystems
        importNixPkgsFor
        importNixPkgsStableFor
        ;
    in
    {
      inherit lib;

      apps = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          localPkgs = pkgs.callPackage ./packages inputs;
        in
        {
          "switch" = app {
            program = "${localPkgs.switch}/bin/switch";
          };
        }
      );

      darwinConfigurations =
        let
          darwinConfiguration =
            {
              user ? config.defaultUser,
              system ? config.defaultDarwinSystem,
              extraOverlays ? [ ],
              modules ? [ ],
            }:
            let
              pkgs = importNixPkgsFor system {
                overlays = overlays.darwin ++ extraOverlays;
              };
              pkgs-stable = importNixPkgsStableFor system { };
              specialArgs = (
                inputs
                // {
                  inherit user pkgs-stable;
                  flake-inputs = inputs;
                }
              );
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

      nixOnDroidConfigurations.default =
        let
          user = config.defaultUser;
          system = "aarch64-linux";
          pkgs = importNixPkgsFor system {
            overlays = overlays.common ++ overlays.android;
          };
          pkgs-stable = importNixPkgsStableFor system;
          extraSpecialArgs = (
            inputs
            // {
              inherit user system pkgs-stable;
              flake-inputs = inputs;
            }
          );
        in
        nix-on-droid.lib.nixOnDroidConfiguration {
          inherit pkgs extraSpecialArgs;
          modules = [
            ./machines/android.nix
          ];
        };

      legacyPackages = forAllSystems (
        system: nixpkgs.legacyPackages.${system}.callPackage ./packages inputs
      );

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);

    };
}
