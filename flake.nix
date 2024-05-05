{
  description = "Nix System Configuration Files";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

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
  };
  outputs = { self, darwin, nix-homebrew, homebrew-bundle, homebrew-core, homebrew-cask, homebrew-garden, home-manager, kubelogin, nixpkgs } @inputs:
    let
      defaultUser = "adam";
      defaultDarwinSystem = "aarch64-darwin";
      defaultTaps = {
        "homebrew/core" = homebrew-core;
        "homebrew/cask" = homebrew-cask;
        "homebrew/bundle" = homebrew-bundle;
      };
      extraTaps = {
        "int128/kubelogin" = kubelogin;
        "garden-io/garden-homebrew" = homebrew-garden;
      };

      mkApp = scriptName: system: {
        type = "app";
        program = "${self}/apps/${system}/${scriptName}";
      };

      mkDarwinApps = system: {
        "switch" = mkApp "switch" system;
      };
      mkDarwinMachine =
        { user ? defaultUser
        , system ? defaultDarwinSystem
        , extraTaps ? [ ]
        , extraModules ? [ ]
        ,
        }:
        let
          specialArgs = (inputs // { user = user; system = system; });
          modules = [
            home-manager.darwinModules.home-manager
            nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                enable = true;
                user = user;
                taps = defaultTaps // extraTaps;
                mutableTaps = true;
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

      darwinConfigurations = {
        "personal-macbook" = mkDarwinMachine {
          extraTaps = extraTaps;
          extraModules = [ ./machines/personal-macbook.nix ];
        };
        "influx-macbook" = mkDarwinMachine {
          extraTaps = extraTaps;
          extraModules = [ ./machines/influx-macbook.nix ];
        };
      };
    };
}

