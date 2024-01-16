{ home, ... }: {
  home.file.".wezterm.lua" = {
    source = ./config/wezterm.lua;
  };

  programs.wezterm = {
    enable = true;
  };
}
