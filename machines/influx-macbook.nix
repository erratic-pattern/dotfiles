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
          ../home/claude.nix
          ../home/directories
          ../home/firefox.nix
          ../home/fzf
          ../home/influx
          ../home/kitty
          ../home/nvim
          ../home/rust
          ../home/shell
          ../home/syncthing
          ../home/wezterm
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
