{ lib, ... }:
let
  # Read file contents of a directory non-recurisvely
  readDirFiles = dir:
    lib.mapAttrs
      (f: type: builtins.readFile "${dir}/${f}")
      (lib.filterAttrs
        (f: type: type == "regular")
        (builtins.readDir dir));
  # Read directory of config files and concatenate contents into a string
  concatConfigFiles = dir:
    lib.concatStringsSep "\n" (lib.attrValues (readDirFiles dir));
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
