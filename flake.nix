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

    vim-tintin = {
      url = "github:LokiChaos/vim-tintin";
      flake = false;
    };
  };
  outputs =
    inputs @ { self
    , darwin
    , nix-homebrew
    , homebrew-bundle
    , homebrew-core
    , homebrew-cask
    , homebrew-garden
    , home-manager
    , kubelogin
    , nixpkgs
    , vim-tintin
    }:
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

      mkDarwinMachine =
        { user ? defaultUser
        , system ? defaultDarwinSystem
        , modules
        ,
        }:
        let
          specialArgs = (inputs // { inherit user system inputs; });
        in
        darwin.lib.darwinSystem {
          inherit system specialArgs modules;
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
          modules = [
            ./machines/personal-macbook.nix
          ];
        };
        "influx-macbook" = mkDarwinMachine {
          modules = [
            ./machines/influx-macbook.nix
          ];
        };
      };
    };
}

