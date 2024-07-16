{ config, pkgs, lib, ... }:
{
  xdg.configFile."tmux" = {
    source = ./config/tmux;
    recursive = true;
  };
  programs.tmux = {
    enable = true;
  };
}
