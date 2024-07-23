# home-manager does not have a localVariables configuration for bash
# so variables for interactive shells go here

# Prompt: name@machine ~/some/path$
PS1="\u@\H \w$ "

# skip from history when command begins with space
HISTCONTROL="ignorespace"

