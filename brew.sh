#!/usr/bin/env bash

# Install Homebrew
echo "Installing Homebrew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo "Homebrew successfully installed"

brew update
brew upgrade

# default terminal
brew install fish

brew install rbenv ruby-build

# github utilities
brew install hub

# install yarn & node
brew install yarn


brew install watchman


brew cleanup


