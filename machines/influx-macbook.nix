{ pkgs, user, ... }:
{
  imports = [
    ../system/darwin-influx
  ];

  networking.hostName = "Adams-Influx-MacBook";
  networking.localHostName = "Adams-Influx-MacBook";
  networking.computerName = "Adam's Influx MacBook";

  home-manager = {
    users.${user} =
      { ... }:
      {
        imports = [
          ../home/influx
          ../home/neovim
          ../home/rust
          ../home/shell
          ../home/wezterm
        ];
      };
  };

  system.defaults.dock.persistent-apps = [
    "/System/Applications/System Settings.app/"
    "/Applications/Google Chrome.app/"
    "/Applications/Slack.app/"
    "/Applications/zoom.us.app/"
    "/Applications/Notion.app/"
    "${pkgs.obsidian}/Applications/Obsidian.app/"
    "${pkgs.wezterm}/Applications/Wezterm.app/"
    "/Applications/1Password.app/"
    "/Applications/Spotify.app/"
  ];
}
