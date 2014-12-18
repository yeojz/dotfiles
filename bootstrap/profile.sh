#
# For default bash prompt
#


# Scripts
source ~/.dotfiles/scripts-addon/git-completion.bash
source ~/.dotfiles/scripts-addon/git-prompt.sh
source ~/.dotfiles/scripts-addon/extract.sh

# Generic 
source ~/.dotfiles/config-generic/android
source ~/.dotfiles/config-generic/env
source ~/.dotfiles/config-generic/git
source ~/.dotfiles/config-generic/helpers
source ~/.dotfiles/config-generic/homebrew
source ~/.dotfiles/config-generic/osx
source ~/.dotfiles/config-generic/ruby
source ~/.dotfiles/config-generic/subl

# Specific
source ~/.dotfiles/config-specific/prompt
source ~/.dotfiles/config-specific/virtualenv

if [ -f ~/.dotfiles.local ]; then
  source ~/.dotfiles.local   
fi

# Export PATH again just in case
export PATH


