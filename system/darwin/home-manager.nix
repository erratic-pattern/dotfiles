{ home-manager, pkgs, ... }:
{
  imports = [
    ../common/home-manager.nix
    home-manager.darwinModules.home-manager
  ];
  nixpkgs = {
    config = pkgs.config;
    overlays = pkgs.overlays;
  };
}
