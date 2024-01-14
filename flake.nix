{
  description = "Nix System Configuration Files";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/";

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
  };
  outputs = { self, darwin, nix-homebrew, homebrew-bundle, homebrew-core, homebrew-cask, homebrew-garden, home-manager, nixpkgs} @inputs:
    with nixpkgs.lib;
    let
      user = "adam";
      darwinSystems = [ "aarch64-darwin" ];

      mkApp = scriptName: system: {
        type = "app";
        program = "${self}/apps/${system}/${scriptName}";
      };

      mkDarwinApps = system: {
        "switch" = mkApp "switch" system;
      };

      commonTaps = {
        "homebrew/core" = homebrew-core;
        "homebrew/cask" = homebrew-cask;
        "homebrew/bundle" = homebrew-bundle;
      };

      influxTaps = {
        "garden-io/garden-homebrew" = homebrew-garden;
      };

    in
    {
      apps = genAttrs darwinSystems mkDarwinApps;

      darwinConfigurations = {
        "personal-macbook" = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = inputs;
          modules = [
            home-manager.darwinModules.home-manager
            nix-homebrew.darwinModules.nix-homebrew
            { 
              nix-homebrew = {
                enable = true;
                user = user;
                taps = mkMerge [ commonTaps influxTaps ];
                mutableTaps = false;
                autoMigrate = true;
              };
            }
            ./machines/personal-macbook.nix
          ];
        };
      };
    };
  }

