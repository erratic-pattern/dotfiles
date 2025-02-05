{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    obsidian
    wezterm
  ];

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
      "slack"
      "spotify"
      "expressvpn"
    ];
  };

  environment.variables = {
    DOCKER_BUILDKIT = "1";
  };

}
