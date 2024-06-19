{ config, pkgs, ... }:
let user = "adam"; in
{
  imports = [
    ../system/darwin-personal
    ../desktop/darwin
  ];

  networking.hostName = "Adams-MacBook-Pro";
  networking.computerName = "Adam's MacBook Pro";

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
        ../home/muds
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
    { path = "/Applications/Discord.app/"; }
    { path = "/Applications/Steam.app/"; }
    {
      path = "${config.users.users.${user}.home}/Downloads";
      section = "others";
      options = "--sort name --view grid --display stack";
    }
  ];
}
