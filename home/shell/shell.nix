{ lib, ... }:
let
  inherit (lib) concatStringsSep map readFile;
  inherit (lib.filesystem) listFilesRecursive;
  # Read a directory of config files recursively and concatenate contents into a string
  concatConfigFiles = dir: concatStringsSep "\n" (map readFile (listFilesRecursive dir));
in
{
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL_EDITOR = "nvim";
  };

  home.shellAliases = {
    ls = "ls --color=auto";
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = concatConfigFiles ./config/bash;
  };

  programs.zsh = {
    enable = true;
    autocd = false;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    history = {
      size = 1000000;
    };
    localVariables = {
      # Prompt: name@machine ~/some/path$
      PS1 = "%n@%m %~$ ";
      # Make Vi mode transitions faster (in hundredths of a second)
      KEYTIMEOUT = 1;
    };
    initExtra = concatConfigFiles ./config/zsh;
  };

  programs.readline = {
    enable = true;
    extraConfig = builtins.readFile ./config/inputrc;
  };
}
