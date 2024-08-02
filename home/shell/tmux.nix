{ pkgs, ... }:
{
  xdg.configFile."tmux" = {
    source = ./config/tmux;
    recursive = true;
  };
  xdg.configFile."tmux/colorscheme.tmux" = {
    source = "${pkgs.vimPlugins.nightfox-nvim}/extra/nightfox/nightfox.tmux";
  };
  programs.tmux = {
    enable = true;
  };
}
