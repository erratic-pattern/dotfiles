{ vim-tintin, ... }:
{
  # add vim-tintin syntax file to nvim config directory
  xdg.configFile."nvim/syntax/tt.vim" = {
    source = "${vim-tintin}/syntax/tt.vim";
  };

  # add nvim config directory
  xdg.configFile."nvim/lua/tintin.lua" = {
    source = ./config/nvim/lua/tintin.lua;
    recursive = true;
  };
}
