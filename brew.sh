#!/bin/bash

[ -f ./functions.sh ] && source ./functions.sh || { echo "Error: functions.sh not found in the current directory."; exit 1; }

# Homebrew Install
if prompt_user "Would you like to install Homebrew?(y/n) "; then
    info_text "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    success_text "Homebrew installed"
else
    info_text "Skipping installing Homebrew..."
fi

# Ruby and rbenv Install
if prompt_user "Would you like to install Ruby and rbenv?(y/n) "; then
    info_text "Installing rbenv and ruby build..."
    brew install rbenv ruby-build
    success_text "rbenv and ruby build installed"
else
    info_text "Skipping installing Ruby and rbenv..."
fi

# Github CLI install
if prompt_user "Would you like to install Github CLI?(y/n) "; then
    info_text "Installing Github CLI..."
    brew install gh
    success_text "Github CLI installed"
else
    info_text "Skipping installing Github CLI..."
fi

# GNU GPG install
if prompt_user "Would you like to install GNU GPG?(y/n) "; then
    info_text "Installing GNU GPG..."
    brew install gnupg
    success_text "GNU GPG installed"
else
    info_text "Skipping installing GNU GPG..."
fi

brew cleanup