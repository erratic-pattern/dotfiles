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
  };
  environment.variables = {
    DOCKER_BUILDKIT = "1";
  };
}
