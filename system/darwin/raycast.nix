{ pkgs, ... }:
let
  inherit (pkgs) raycast;
in
{
  environment.systemPackages =
    [
      raycast
    ];
  system.defaults.CustomUserPreferences = {
    "com.apple.symbolichotkeys" = {
      AppleSymbolicHotKeys = {
        # Disable spotlight keybind
        "64" = {
          enabled = false;
        };
      };
    };
  };
  services.skhd = {
    skhdConfig = ''
      cmd - space : open ${raycast}/Applications/Raycast.app
    '';
  };
}
