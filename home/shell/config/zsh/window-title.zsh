# set terminal title to cwd
DISABLE_AUTO_TITLE="true"
function set_title_to_pwd() {
    echo -en "\e]2;$(pwd | sed "s/${HOME//\//\\/}/~/")"
}
autoload add-zsh-hook
add-zsh-hook chpwd set_title_to_pwd
set_title_to_pwd

