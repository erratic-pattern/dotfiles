
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
        # "1password" = 1333542190;
        "tailscale" = 1475387142;
    };

    brews = [
        # "influxdb-cli"
        # "garden-cli@0.12"
    ];

    casks = [
        # Communication Tools
        "slack"
        "zoom"
    ];
  };
}
