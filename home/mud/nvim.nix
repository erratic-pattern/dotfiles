{ vim-tintin, ... }:
{
  # add vim-tintin syntax file to nvim config directory
  xdg.configFile."nvim/syntax/tt.vim" = {
    source = "${vim-tintin}/syntax/tt.vim";
  };

  # add nvim config directory
  xdg.configFile."nvim/after/plugin/tintin.lua" = {
    source = ./config/nvim/after/plugin/tintin.lua;
    recursive = true;
  };
}
