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

    ];
    brews = [
      # Prefer to manage Python through homebrew for now
      "python@3.12"
      "python-dateutil"
    ];
  };
  environment.variables = {
    DOCKER_BUILDKIT = "1";
  };
}
