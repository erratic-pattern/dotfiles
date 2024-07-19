{ config, pkgs, user, ... }: {
  imports = [
    ../system/darwin-influx
  ];

  networking.hostName = "Adams-Influx-MacBook";
  networking.localHostName = "Adams-Influx-MacBook";
  networking.computerName = "Adam's Influx MacBook";

  home-manager = {
    users.${user} = { ... }: {
      imports = [
        ../home/darwin
        ../home/influx
        ../home/neovim
        ../home/shell
        ../home/wezterm
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
