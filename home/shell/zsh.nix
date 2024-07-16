{ ... }:
{
  programs.zsh = {
    enable = true;
    defaultKeymap = "viins";
    autocd = false;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    initExtra = builtins.readFile (./config/zshrc);
  };
}
