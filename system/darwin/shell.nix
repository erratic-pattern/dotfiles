{ ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  environment.pathsToLink = [ "/share/zsh" ];
}
