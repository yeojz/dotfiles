#
# For default bash prompt
#

# Generic 
source ~/.dotfiles/config/index.sh


# Specific
source ~/.dotfiles/scripts-env/git-completion.sh
source ~/.dotfiles/scripts-env/git-prompt.sh


if [ -f ~/.dotfiles.local ]; then
  source ~/.dotfiles.local
fi

# Export PATH again just in case
export PATH


