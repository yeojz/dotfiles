#!/bin/sh

if test ! $(which nvm)
then
  echo "  Installing Node stable"
  nvm install stable

  echo "  Installing io.js latest"
  nvm install iojs

  echo "  Set node version to use"
  nvm alias default stable
fi
