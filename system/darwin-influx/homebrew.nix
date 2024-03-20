{ ... }:
{
  homebrew = {
    # These app IDs are from using the mas CLI app
    # mas = mac app store
    # https://github.com/mas-cli/mas
    #
    # $ nix shell nixpkgs#mas
    # $ mas search <app name>
    #
    masApps = {
      "tailscale" = 1475387142;
    };

    brews = [
    ];

    casks = [
      # Communication Tools
      "slack"
      "zoom"
    ];
  };
}
