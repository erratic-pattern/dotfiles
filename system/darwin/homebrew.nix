{ config, pkgs, lib, user, home-manager, nix-homebrew, homebrew-core, homebrew-cask, homebrew-bundle, ... }:
let
  brewShellEnv = ''eval "$(/opt/homebrew/bin/brew shellenv)"'';
in
{
  nix-homebrew = {
    enable = true;
    user = user;
    taps = {
      "homebrew/core" = homebrew-core;
      "homebrew/cask" = homebrew-cask;
      "homebrew/bundle" = homebrew-bundle;
    };
    mutableTaps = true;
    autoMigrate = true;
  };

  programs.zsh = {
    shellInit = brewShellEnv;
  };

  programs.bash = {
    interactiveShellInit = brewShellEnv;
  };
}
