{ ... }:
{
  imports = [
    ./shell.nix
    ./fonts.nix
    ./homebrew.nix
    ./home-manager.nix
    # ./spotlight-fix.nix
    ./system-settings.nix
    ./user.nix
    ../common
  ];
}
