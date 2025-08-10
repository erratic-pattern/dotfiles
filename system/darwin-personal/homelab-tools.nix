# Tools for remote NixOS homelab builds
{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    nixos-rebuild
    nixos-generators
    wireguard-tools
  ];

  nix.linux-builder = {
    enable = true;
    ephemeral = false;
    maxJobs = 4;
    config = {
      virtualisation = {
        darwin-builder = {
          diskSize = 40 * 1024;
          memorySize = 8 * 1024;
        };
        cores = 6;
      };
    };
    package = pkgs.darwin.linux-builder-x86_64;

  };
}
