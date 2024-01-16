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
  outputs = { self, darwin, nix-homebrew, homebrew-bundle, homebrew-core, homebrew-cask, homebrew-garden, home-manager, nixpkgs } @inputs:
  let
    defaultUser = "adam";
    defaultDarwinSystem = "aarch64-darwin";
    mkApp = scriptName: system: {
      type = "app";
      program = "${self}/apps/${system}/${scriptName}";
    };

    mkDarwinApps = system: {
      "switch" = mkApp "switch" system;
    };
    mkDarwinMachine = {
      user ? defaultUser,
      system ? defaultDarwinSystem,
      extraTaps ? [],
      extraModules ? [], }:
      let
        specialArgs = (inputs // {user = user; system = system;});
        taps = {
          "homebrew/core" = homebrew-core;
          "homebrew/cask" = homebrew-cask;
          "homebrew/bundle" = homebrew-bundle;
        };
        modules = [
          home-manager.darwinModules.home-manager
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              user = user;
              taps = taps // extraTaps;
              mutableTaps = false;
              autoMigrate = true;
            };
          }
        ];
      in
      darwin.lib.darwinSystem {
        system = system;
        specialArgs = specialArgs;
        modules = modules ++ extraModules;
      };
  in
  {
    apps =
      let
        darwinSystems = [ "aarch64-darwin" ];
        darwinApps = nixpkgs.lib.genAttrs darwinSystems mkDarwinApps;
      in
      darwinApps;

      darwinConfigurations =
        let
          influxTaps = {
            "garden-io/garden-homebrew" = homebrew-garden;
          };
        in
        {
          "personal-macbook" = mkDarwinMachine {
            extraTaps = influxTaps;
            extraModules = [ ./machines/personal-macbook.nix ];
          };
          "influx-macbook" = mkDarwinMachine {
            extraTaps = influxTaps;
            extraModules = [ ./machines/influx-macbook.nix ];
          };
        };
      };
    }

