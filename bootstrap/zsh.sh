#
# For ZSH or oh-my-zsh
#

# Generic
source ~/.dotfiles/config/android
source ~/.dotfiles/config/env
source ~/.dotfiles/config/git
source ~/.dotfiles/config/helpers
source ~/.dotfiles/config/homebrew
source ~/.dotfiles/config/homebrew-cask
source ~/.dotfiles/config/nvm
source ~/.dotfiles/config/osx
source ~/.dotfiles/config/ruby
source ~/.dotfiles/config/subl
source ~/.dotfiles/config/virtualenv
source ~/.dotfiles/config/visualstudio



if [ -f ~/.dotfiles.local ]; then
  source ~/.dotfiles.local
fi

# Export PATH again just in case
export PATH


