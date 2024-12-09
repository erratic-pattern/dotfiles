{ pkgs, user, ... }: {
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
        ../home/darwin
        ../home/influx
        ../home/mud
        ../home/neovim
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
    "${pkgs.wezterm}/Applications/Wezterm.app/"
    "/Applications/1Password.app/"
    "/Applications/Spotify.app/"
    "/Applications/Discord.app/"
    "/Applications/Steam.app/"
  ];
}
