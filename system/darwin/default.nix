{ ... }:
{
  imports = [
    ./fonts.nix
    ./home-manager.nix
    ./homebrew.nix
    ./packages.nix
    ./shell.nix
    # ./spotlight-fix.nix
    ./system-settings.nix
    ./user.nix
    ../common
  ];
}
