{ ... }: {

  homebrew = {

    enable = true;

    casks = [
      # Development Tools
      "docker"

      # Security
      "1password"

      # Browsers
      "google-chrome"

      # Notes
      "notion"

      # Cloud Storage
      "dropbox"

      # Music
      "spotify"

      # Wacom Tablet Drivers
      "wacom-tablet"
    ];
  };
}
