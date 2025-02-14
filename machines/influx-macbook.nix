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
          ../home/nvim
          ../home/rust
          ../home/shell
          ../home/wezterm
          ../home/directories
          ../home/syncthing
          ../home/kitty
          ../home/fzf
        ];
      };
  };

  system.defaults.dock.persistent-apps = [
    "/System/Applications/System Settings.app/"
    "/Applications/Google Chrome.app/"
    "${pkgs.slack}/Applications/Slack.app/"
    "/Applications/zoom.us.app/"
    "/Applications/Nix Apps/Notion.app/"
    "${pkgs.obsidian}/Applications/Obsidian.app/"
    "${pkgs.kitty}/Applications/Kitty.app/"
    "${pkgs.wezterm}/Applications/Wezterm.app/"
    "/Applications/1Password.app/"
    "${pkgs.spotify}/Applications/Spotify.app/"
  ];
}
