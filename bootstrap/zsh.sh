#
# For ZSH or oh-my-zsh
#

# Generic 
source ~/.dotfiles/config/index.sh


if [ -f ~/.dotfiles.local ]; then
  source ~/.dotfiles.local
fi

# Export PATH again just in case
export PATH


