{ pkgs, ... }:
let
  name = "Adam Curtis";
  email = "adam.curtis.dev@gmail.com";
in
{
  programs.git = {
    enable = true;
    userName = name;
    userEmail = email;
    lfs = {
      enable = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
      # commit.gpgsign = true;
      pull.rebase = true;
      rebase.autoStash = true;
      push.autoSetupRemote = true;
      merge.tool = "nvim";
      mergetool.nvim.cmd = "nvim -d -c 'wincmd l' -c 'norm ]c' \"$LOCAL\" \"$MERGED\" \"$REMOTE\"";
      diff.external="${pkgs.difftastic}/bin/difft";
    };
  };
}
