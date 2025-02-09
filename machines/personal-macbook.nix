{ pkgs, user, ... }:
{
  imports = [
    ../system/darwin-personal
    ../system/darwin-influx
  ];

  networking.hostName = "Adams-MacBook";
  networking.localHostName = "Adams-MacBook";
  networking.computerName = "Adam's MacBook";

  home-manager = {
    users.${user} =
      { ... }:
      {
        imports = [
          ../home/influx
          ../home/mud
          ../home/neovim
          ../home/rust
          ../home/shell
          ../home/wezterm
          ../home/directories.nix
          ../home/syncthing.nix
        ];
      };
  };

  system.defaults.dock.persistent-apps = [
    "/System/Applications/System Settings.app/"
    "/Applications/Google Chrome.app/"
    "${pkgs.slack}/Applications/Slack.app/"
    "/Applications/zoom.us.app/"
    "/Applications/Notion.app/"
    "${pkgs.obsidian}/Applications/Obsidian.app/"
    "${pkgs.wezterm}/Applications/Wezterm.app/"
    "/Applications/1Password.app/"
    "${pkgs.spotify}/Applications/Spotify.app/"
    "${pkgs.discord}/Applicptions/Discord.app/"
    "/Applications/Steam.app/"
  ];
}
