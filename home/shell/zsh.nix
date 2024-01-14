{...}:
{
  programs.zsh = {
    enable = true;
    autocd = false;
    enableCompletion = true;
    initExtraFirst = builtins.readFile(./config/zshrc);
  };
}
