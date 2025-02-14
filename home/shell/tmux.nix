{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (builtins) readFile;
  inherit (lib) mkMerge mkBefore mkAfter;
  tmuxConf = readFile ./config/tmux/tmux.conf;
  colorSchemeConf = readFile "${pkgs.vimPlugins.nightfox-nvim}/extra/nightfox/nightfox.tmux";
in
mkMerge [
  {
    home.packages = with pkgs; [
      tmux
    ];
  }
  { xdg.configFile."tmux/tmux.conf".text = mkBefore tmuxConf; }
  { xdg.configFile."tmux/tmux.conf".text = mkAfter (config.programs.tmux.extraConfig); }
  { xdg.configFile."tmux/tmux.conf".text = mkAfter colorSchemeConf; }
]
