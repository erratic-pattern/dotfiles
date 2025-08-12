{
  pkgs,
  lib,
  user,
  ...
}:
{
  home.packages = with pkgs; [
    claude-code
  ];

  home.file.".claude/settings.json" = {
    text = builtins.toJSON {
      includeCoAuthoredBy = false;
      cleanupPeriodDays = 90;
      # statusLine = {
      #   type = "command";
      #   command = "/Users/${user}/.claude/statusline.sh";
      # };
    };
  };

  # home.file.".claude/statusline.sh" = {
  #   text = ''
  #     #!/bin/bash
  #     # Parse JSON input from Claude Code
  #     model_name=$(echo "$1" | jq -r '.model.display_name // .model.id')
  #     current_dir=$(echo "$1" | jq -r '.workspace.current_dir // .cwd' | xargs basename)
  #     project_dir=$(echo "$1" | jq -r '.workspace.project_dir' | xargs basename)
  #     session_id=$(echo "$1" | jq -r '.session_id')
  #
  #     # Get Claude Code version (fallback if not in JSON)
  #     version=$(claude --version 2>/dev/null | cut -d' ' -f2 || echo "unknown")
  #
  #     # Calculate session duration
  #     session_start_file="/tmp/claude_session_$session_id"
  #     if [[ ! -f "$session_start_file" ]]; then
  #       echo "$(date +%s)" > "$session_start_file"
  #     fi
  #     start_time=$(cat "$session_start_file" 2>/dev/null || echo "$(date +%s)")
  #     current_time=$(date +%s)
  #     duration_minutes=$(( (current_time - start_time) / 60 ))
  #
  #     # Count files in current directory (non-hidden)
  #     file_count=$(find "$(pwd)" -maxdepth 1 -type f ! -name ".*" 2>/dev/null | wc -l | tr -d ' ')
  #
  #     # Count TODO items (common patterns in code)
  #     todo_count=$(grep -r -i "TODO\|FIXME\|XXX" . --include="*.md" --include="*.txt" --include="*.nix" --include="*.sh" --include="*.py" --include="*.js" --include="*.ts" --include="*.rs" --include="*.go" --include="*.c" --include="*.cpp" --include="*.java" 2>/dev/null | wc -l | tr -d ' ')
  #
  #     # Format status line with colors
  #     echo -e "\033[36m''${model_name}\033[0m | \033[33m''${current_dir}\033[0m | \033[32m''${project_dir}\033[0m | \033[35mv''${version}\033[0m | \033[34m''${duration_minutes}m\033[0m | \033[37m''${file_count}f\033[0m | \033[31m''${todo_count}TODO\033[0m"
  #   '';
  #   executable = true;
  # };

  # Declaratively manage editorMode in ~/.claude.json
  home.activation.setClaudeVimMode = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [[ -f ~/.claude.json ]]; then
      run ${pkgs.jq}/bin/jq '.editorMode = "vim"' ~/.claude.json > ~/.claude.json.tmp
      run mv ~/.claude.json.tmp ~/.claude.json
    else
      run echo '{"editorMode": "vim"}' > ~/.claude.json
    fi
  '';

}
