{ ... }: {
  homebrew = {
    enable = true;

    # These app IDs are from using the mas CLI app
    # mas = mac app store
    # https://github.com/mas-cli/mas
    #
    # $ nix shell nixpkgs#mas
    # $ mas search <app name>
    #
    masApps = {
      # "1password" = 1333542190;
    };

    casks = [
      "docker"
      "1password"
      "google-chrome"
      "notion"
      "dropbox"
      "google-drive"
      "spotify"
      "expressvpn"
      "steam"
      "element"
    ];
  };

  environment.variables = {
    DOCKER_BUILDKIT = "1";
  };
}
