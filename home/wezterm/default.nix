{ ... }:
{
  home.file.".wezterm.lua" = {
    source = ./wezterm.lua;
  };

  programs.wezterm = {
    enable = true;
  };
}
