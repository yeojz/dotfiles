#
# For default bash prompt
#


# Scripts
source ~/dotfiles/scripts/git-completion.bash
source ~/dotfiles/scripts/git-prompt.sh

# Generic 
source ~/dotfiles/config-generic/android
source ~/dotfiles/config-generic/exports
source ~/dotfiles/config-generic/homebrew
source ~/dotfiles/config-generic/mac
source ~/dotfiles/config-generic/rewrites
source ~/dotfiles/config-generic/ruby
source ~/dotfiles/config-generic/subl

# Specific
source ~/dotfiles/config-specific/prompt
source ~/dotfiles/config-specific/virtualenv

# Export PATH again just in case
export PATH

