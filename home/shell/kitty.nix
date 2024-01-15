{ ... } : {
  programs.kitty = {
    enable = true;
    settings = {
      font_family = "Fira Code";
      font_size = 14;
      disable_ligatures = "cursor";
      cursor_shape = "block";
      scrollback_lines = 10000;
    };

    extraConfig = builtins.readFile ./config/kitty/tokyonight_moon.conf;
  };
}
 
