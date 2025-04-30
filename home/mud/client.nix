{ pkgs, ... }:
let
  ttAlias = # sh
    "alias -- tt='tt++ ~/.tintin/init.tt'";
in
{
  home.packages = with pkgs; [
    tintin
    mudlet
  ];

  # TinTin config files
  home.file.".tintin" = {
    source = ./config/tintin;
    recursive = true;
  };

  # quick alias to load tintin with config
  programs.zsh = {
    initContent = ttAlias;
  };

  programs.bash = {
    initExtra = ttAlias;
  };
}
