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
    };

    casks = [
        # VPN
        "expressvpn"
        # Games
        "steam"
        "discord"
        # Social
        "element"
    ];
  };
}
