#!/bin/sh
code_dir="$HOME/Code"
selected="$( \
    find "$code_dir" -maxdepth 1 -type d -exec basename {} \; \
    | fzf \
)"

if [ -z "$selected" ]; then
    exit 0
fi

selected_dir="$code_dir/$selected"

session="$(echo "$selected" | tr '_\. ' _)"

if [ -z "$(pgrep tmux)" ]; then
    exec tmux new-session -s "$session" -c "$selected_dir"
fi

if ! tmux has-session -t="$session" 2> /dev/null; then
    tmux new-session -ds "$session" -c "$selected_dir"
fi

tmux switch-client -t "$session"

