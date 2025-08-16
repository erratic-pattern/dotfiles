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
          ../home/1password.nix
          ../home/claude.nix
          ../home/directories
          ../home/finance
          ../home/firefox.nix
          ../home/fzf
          ../home/influx
          ../home/kitty
          ../home/mud
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
    "${pkgs.firefox}/Applications/Firefox.app/"
    "${pkgs.slack}/Applications/Slack.app/"
    "/Applications/zoom.us.app/"
    "/Applications/Notion.app/"
    "${pkgs.obsidian}/Applications/Obsidian.app/"
    "${pkgs.wezterm}/Applications/Wezterm.app/"
    "${pkgs.kitty}/Applications/Kitty.app/"
    "/Applications/1Password.app/"
    "${pkgs.spotify}/Applications/Spotify.app/"
    "${pkgs.discord}/Applications/Discord.app/"
    "/Applications/Steam.app/"
  ];
}
