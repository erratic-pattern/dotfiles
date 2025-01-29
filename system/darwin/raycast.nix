{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    raycast
  ];
  # Custom keyboard shortcuts
  CustomUserPreferences = {
    "com.apple.symbolichotkeys" = {
      AppleSymbolicHotKeys = {
        # Disable spotlight keybind
        "64" = {
          enabled = false;
        };
      };
    };
  };
}
