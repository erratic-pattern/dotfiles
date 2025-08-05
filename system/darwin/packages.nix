{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    obsidian
    slack
    spotify
    wezterm
    kitty
  ];

  programs._1password-gui.enable = true;

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
      "dropbox"
      "expressvpn"
      "google-chrome"
      "google-drive"
      "notion"
      "libreoffice"
    ];
  };

  environment.variables = {
    DOCKER_BUILDKIT = "1";
  };

}
