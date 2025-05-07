{ pkgs, ... }:
let
  fzf-directories =
    pkgs.writeScript "fzf-directories" # sh
      ''
        find "$HOME/Code" -maxdepth 1 -type d \
        | fzf \
            --bind=ctrl-z:ignore --reverse --walker=file,dir,follow,hidden --scheme=path +m \
            ''${FZF_TMUX_SWITCHER_HEIGHT:+ --height "$FZF_TMUX_SWITCHER_HEIGHT"} \
            ''${FZF_TMUX_SWITCHER_MIN_HEIGHT:+ --min-height "$ZF_TMUX_SWITCHER_MIN_HEIGHT"} \
      '';

  switch-tmux-session =
    pkgs.writeScript "switch-tmux-session" # sh
      ''
        selected="$1"
        session="$(basename "$selected" | tr '_\. ' _)"
        if [ -z "$TMUX" ]; then
          exec tmux new-session -A -s "$session" -c "$selected"
        fi
        if ! tmux has-session -t "$session" 2>/dev/null; then
          tmux new-session -d -s "$session" -c "$selected"
        fi
        exec tmux switch-client -t "$session"
      '';

  fzf-tmux-session-switcher =
    pkgs.writeScript "fzf-tmux-session-switcher" # sh
      ''
        selected="$(${fzf-directories})"
        exec ${switch-tmux-session} "$selected"
      '';

  session-switcher-cmd = ''split-window -v -l '35%' -e 'FZF_TMUX_SWITCHER_HEIGHT=100%' ${fzf-tmux-session-switcher}'';
in
{
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  home.sessionVariables = {
    FZF_DEFAULT_OPTS = "--height=50% --min-height +15";
  };

  programs.tmux = {
    extraConfig = ''
      bind-key f ${session-switcher-cmd}
      bind-key C-f ${session-switcher-cmd}
      bind-key -T root C-f ${session-switcher-cmd}
    '';
  };

  programs.zsh = {
    initContent =
      # sh
      ''
        alias switch-session='${switch-tmux-session}'
        function fzf-tmux-session-switcher-zle-widget() {
          setopt localoptions pipefail no_aliases 2> /dev/null
          selected="$(${fzf-directories} < /dev/tty)"
          if [[ -z "$selected" ]]; then
            zle redisplay
            return 0
          fi
          zle push-line
          BUFFER="switch-session '$selected'"
          zle accept-line
          local ret=$?
          unset selected # ensure this doesn't end up appearing in prompt expansion
          zle reset-prompt
          return $ret
        }
        zle -N fzf-tmux-session-switcher-zle-widget
        bindkey '^f' fzf-tmux-session-switcher-zle-widget
      '';
  };
  programs.bash = {
    initExtra = ''
      alias -- switch-session='${switch-tmux-session}'
      bind -x '"\C-f": ${fzf-tmux-session-switcher}'
    '';
  };
}
