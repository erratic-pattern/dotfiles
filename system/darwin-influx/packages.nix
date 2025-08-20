{
  kubelogin,
  homebrew-garden,
  ...
}:
{

  imports = [
    ../darwin/packages.nix
  ];

  nix-homebrew = {
    taps = {
      "int128/kubelogin" = kubelogin;
      "garden-io/garden-homebrew" = homebrew-garden;
    };
  };

  homebrew = {
    # These app IDs are from using the mas CLI app
    # mas = mac app store
    # https://github.com/mas-cli/mas
    #
    # $ nix shell nixpkgs#mas
    # $ mas search <app name>
    #

    masApps = {
      # VPN
      # "tailscale" = 1475387142;
    };

    casks = [
      "zoom"
    ];
  };
}
