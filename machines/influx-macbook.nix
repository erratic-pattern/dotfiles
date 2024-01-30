{ config, pkgs, ... }:
let user = "adam"; in
{
  imports = [
    ../system/darwin-influx
    ../desktop/darwin
  ];

  networking.hostName = "Adams-Influx-MacBook-Pro";
  networking.localHostName = "Adams-Influx-MacBook-Pro";
  networking.computerName = "Adam's Influx MacBook Pro";

  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  # Enable home-manager
  home-manager = {
    useGlobalPkgs = true;
    users.${user} = { pkgs, config, lib, ... }:{
      imports = [
        ../home/shell
        ../home/darwin
        ../home/influx
      ];
      home.enableNixpkgsReleaseCheck = false;
      home.stateVersion = "21.11";
    };
  };

  local.dock.enable = true;
  local.dock.entries = [
    { path = "/System/Applications/System Settings.app/"; }
    { path = "/Applications/Google Chrome.app/"; }
    { path = "/Applications/Slack.app/"; }
    { path = "/Applications/zoom.us.app/"; }
    { path = "/Applications/Notion.app/"; }
    { path = "${pkgs.wezterm}/Applications/Wezterm.app/"; }
    { path = "/Applications/1Password.app/"; }
    { path = "/Applications/Spotify.app/"; }
    {
      path = "${config.users.users.${user}.home}/Downloads";
      section = "others";
      options = "--sort name --view grid --display stack";
    }
  ];
}
