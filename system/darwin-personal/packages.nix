{ pkgs, ... }:
{

  imports = [
    ../darwin/packages.nix
  ];

  environment.systemPackages = with pkgs; [
    discord
    element-desktop
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
      "steam"
      "qflipper" # broken on darwin in nixpkgs
    ];
  };
}
