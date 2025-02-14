{ pkgs, ... }:
let
  fzf-switch-session = ./fzf-switch-session.sh;

  tmux-fzf-switch-session = pkgs.writeShellScript "tmux-fzf-switch-session" ''
    tmux split-window -v -l '45%' ${fzf-switch-session}
  '';

  tmux-switch-session-cmd = ''run-shell "${tmux-fzf-switch-session}"'';
in
{
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
  programs.tmux = {
    extraConfig = ''
      bind-key f ${tmux-switch-session-cmd}
      bind-key C-f ${tmux-switch-session-cmd}
      bind-key -T root C-f ${tmux-switch-session-cmd}
    '';
  };
}
