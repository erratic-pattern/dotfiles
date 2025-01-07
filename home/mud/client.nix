{ pkgs, ... }: {
  home.packages = with pkgs; [
    tintin
    # mudlet
  ];

  # TinTin config files
  home.file.".tintin" = {
    source = ./config/tintin;
    recursive = true;
  };

  # quick alias to load tintin with config
  programs.zsh = {
    initExtra = ''
      alias tt='tt++ ~/.tintin/init.tt'
    '';
  };
}
