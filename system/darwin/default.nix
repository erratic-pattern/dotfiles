{ home-manager, ... }:
{
  imports = [
    home-manager.darwinModules.home-manager
    ./fonts.nix
    ./homebrew.nix
    ./packages.nix
    ./podman
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
