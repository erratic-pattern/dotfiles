{...}:
{
  programs.zsh = {
    enable = true;
    autocd = false;
    enableCompletion = true;
    initExtra = builtins.readFile(./config/zshrc);
  };
}
