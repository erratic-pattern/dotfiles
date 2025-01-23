{ home-manager, nix-homebrew, ... }:
{
  imports = [
    home-manager.darwinModules.home-manager
    nix-homebrew.darwinModules.nix-homebrew
    ./shell.nix
    ./fonts.nix
    ./homebrew.nix
    ./spotlight-fix.nix
    ./system-settings.nix
    ./user.nix
    ../common
  ];
}
