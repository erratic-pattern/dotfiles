{...}:
{
  programs.alacritty = {
    enable = true;
    settings = {
      cursor = {
        style = "Block";
      };

      window = {
        opacity = 1.0;
        padding = {
          x = 8;
        };
      };

      font = {
        normal = {
          family = "Fira Code";
          style = "Regular";
        };
        size = 14;
      };

      # dynamic_padding = true;
      # decorations = "full";
    };
  };
}
