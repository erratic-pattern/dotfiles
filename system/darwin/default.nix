{ ... }:
{
  imports = [
    ./fonts.nix
    ./home-manager.nix
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
