{ ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
  };

  programs.bash = {
    enable = true;
    completion.enable = true;
  };

  environment.pathsToLink = [ "/share/zsh" ];
}
