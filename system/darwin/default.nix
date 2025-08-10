{ home-manager, ... }:
{
  imports = [
    home-manager.darwinModules.home-manager
    ./1password.nix
    ./fonts.nix
    ./homebrew.nix
    ./packages.nix
    ./raycast.nix
    ./shell.nix
    ./skhd.nix
    # ./spotlight-fix.nix
    ./ssh.nix
    ./system-settings.nix
    ./user.nix
    ../common
  ];
}
