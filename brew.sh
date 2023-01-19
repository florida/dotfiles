#!/bin/bash

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow

Color_Off='\033[0m'       # Text Reset

write_banner() {
  local text="$1"
  local color="${2:-$BGreen}"

  # Set the fixed width of the banner
  local width=100

  # Draw the banner using the text
  echo
  printf "${color}"
  printf "=%.0s" $(seq 1 $width)
  printf "=\n"
  printf "|%*s %s %*s|\n" $(((width - ${#text} - 2)/2)) "" "$text" $(((width - ${#text} - 2)/2))
  printf "=%.0s" $(seq 1 $width)
  printf "=\n"
  printf "${Color_Off}"
  echo
}

bold_text() {
    local text=$1
    echo -e "${BBlack}${text}${Color_Off}"
}

info_text() {
    local text=$1
    echo -e "${BYellow}${text}${Color_Off}"
}

alert_text() {
    local text=$1
    echo -e "${BRed}${text}${Color_Off}"
}

success_text() {
    local text=$1
    echo -e "${BGreen}${text}${Color_Off}"
}

prompt_user() {
  local question="$1"
  local validation_text="$2"

  while true; do
    read -p "$question" answer
    case $answer in
      [yY] ) return 0;;
      [nN] ) return 1;;
      * ) echo "Please enter 'y' for yes or 'n' for no.";;
    esac
  done
}

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