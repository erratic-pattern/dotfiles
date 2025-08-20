{
  description = "Nix System Configuration Files";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
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
      nixpkgs-unstable,
      nixpkgs-stable,
      darwin,
      nix-on-droid,
      ...
    }:
    let
      lib = import ./lib.nix inputs;
      overlays = import ./overlays inputs;
      inherit (lib)
        app
        forAllSystems
        importNixPkgs
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
              user ? lib.defaultUser,
              system ? "aarch64-darwin",
              extraOverlays ? [ ],
              modules ? [ ],
            }:
            let
              localPkgs = pkgs.callPackage ./packages inputs;
              pkgs = importNixPkgs nixpkgs system {
                overlays = overlays.darwin ++ extraOverlays;
              };
              pkgs-unstable = importNixPkgs nixpkgs-unstable system {
                overlays = overlays.darwin ++ extraOverlays;
              };
              pkgs-stable = importNixPkgs nixpkgs-stable system { };
              specialArgs = (
                inputs
                // {
                  inherit
                    user
                    pkgs-unstable
                    pkgs-stable
                    localPkgs
                    ;
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
          user = lib.defaultUser;
          system = "aarch64-linux";
          pkgs = importNixPkgs nixpkgs system {
            overlays = overlays.android;
          };
          pkgs-unstable = importNixPkgs nixpkgs-unstable system {
            overlays = overlays.android;
          };
          pkgs-stable = importNixPkgs nixpkgs-stable system;
          extraSpecialArgs = (
            inputs
            // {
              inherit
                user
                system
                pkgs-unstable
                pkgs-stable
                ;
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

      packages = forAllSystems (system: nixpkgs.legacyPackages.${system}.callPackage ./packages inputs);

      legacyPackages = forAllSystems (
        system: nixpkgs.legacyPackages.${system}.callPackage ./packages inputs
      );

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);

    };
}
