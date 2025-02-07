{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    obsidian
    slack
    spotify
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
      "1password"
      "docker"
      "dropbox"
      "expressvpn"
      "google-chrome"
      "google-drive"
      "notion"
    ];
  };

  environment.variables = {
    DOCKER_BUILDKIT = "1";
  };

}
