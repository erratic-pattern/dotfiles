# Use Emacs mode by default, and remap META key to ESC for keybinds
# warning: `bindkey -m' disables multibyte support
bindkey -e

# ZSH keybinds
# list current binds: keybind
# list keymaps: keybind -l
# list keybinds for keymap: keybind -M keymap
# list all available commands: zle -al

#ESC in Emacs mode to go to Vi command mode
bindkey -M emacs "\e" vi-cmd-mode

#emacs-style incremental history search in Vi mode
bindkey -M vicmd '^R' history-incremental-search-backward
bindkey -M vicmd '^_' history-incremental-search-backward
bindkey -M vicmd '^?' history-incremental-search-forward

#Fixes Delete key
bindkey "^[[3~" delete-char

#prevents ESC from swallowing the next character
bindkey -M vicmd "\e" vi-cmd-mode

