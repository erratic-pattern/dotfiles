{ home-manager, ... }:
{
  imports = [
    home-manager.darwinModules.home-manager
    ./fonts.nix
    ./homebrew.nix
    ./packages.nix
    ./raycast.nix
    ./shell.nix
    ./skhd.nix
    # ./spotlight-fix.nix
    ./system-settings.nix
    ./user.nix
    ../common
  ];
}
