#
# For default bash prompt
#

# Generic
source ~/.dotfiles/config/android
source ~/.dotfiles/config/docker
source ~/.dotfiles/config/env
source ~/.dotfiles/config/git
source ~/.dotfiles/config/helpers
source ~/.dotfiles/config/homebrew
source ~/.dotfiles/config/homebrew-cask
source ~/.dotfiles/config/laravel
source ~/.dotfiles/config/npm
source ~/.dotfiles/config/nvm
source ~/.dotfiles/config/osx
source ~/.dotfiles/config/ruby
source ~/.dotfiles/config/subl
source ~/.dotfiles/config/virtualenv
source ~/.dotfiles/config/visualstudio


# scripts
source ~/.dotfiles/scripts/dockerup.sh

# Specific
source ~/.dotfiles/scripts-env/git-completion.sh
source ~/.dotfiles/scripts-env/git-prompt.sh


if [ -f ~/.dotfiles.local ]; then
  source ~/.dotfiles.local
fi

if [ -d ~/.dotbins ]; then
  PATH=~/.dotbins:$PATH
fi

# Export PATH again just in case
export PATH


