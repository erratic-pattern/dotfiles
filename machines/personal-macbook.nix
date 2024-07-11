{ config, pkgs, user, ... }: {
  imports = [
    ../system/darwin-personal
    ../system/darwin-influx
  ];

  networking.hostName = "Adams-MacBook";
  networking.localHostName = "Adams-MacBook";
  networking.computerName = "Adam's MacBook";

  home-manager = {
    users.${user} = { ... }: {
      imports = [
        ../home/shell
        ../home/darwin
        ../home/mud
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
    { path = "/Applications/Discord.app/"; }
    { path = "/Applications/Steam.app/"; }
    {
      path = "${config.users.users.${user}.home}/Downloads";
      section = "others";
      options = "--sort name --view grid --display stack";
    }
  ];
}
