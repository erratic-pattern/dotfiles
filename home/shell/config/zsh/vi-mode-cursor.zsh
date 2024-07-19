# change cursor based on vim keybind mode (normal/insert)
zle-keymap-select () {
    if [ $KEYMAP = vicmd ]; then
        printf "\033[2 q"
    else
        printf "\033[6 q"
    fi
}
zle -N zle-keymap-select
zle-line-init () {
    printf "\033[6 q"
}
zle -N zle-line-init
