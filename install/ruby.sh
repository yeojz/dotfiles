#!/usr/bin/env bash

# Install Ruby and Configure Env


if test ! $(which rbenv)
then
  echo "  Installing rbenv..."
  brew install rbenv > /tmp/dotfiles-rbenv.log
fi

if test ! $(which ruby-build)
then
  echo "  Installing ruby-build..."
  brew install ruby-build > /tmp/dotfiles-ruby-build.log
fi




# if test $(which rbenv) 
#   if test $(which ruby-build)
#   then
#   fi
# fi