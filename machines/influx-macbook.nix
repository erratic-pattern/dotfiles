{ config, pkgs, user, ... }: {
  imports = [
    ../system/darwin-influx
    ../desktop/darwin
  ];

  networking.hostName = "Adams-Influx-MacBook-Pro";
  networking.localHostName = "Adams-Influx-MacBook-Pro";
  networking.computerName = "Adam's Influx MacBook Pro";

  home-manager = {
    users.${user} = { ... }:{
      imports = [
        ../home/shell
        ../home/darwin
        ../home/influx
      ];
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
