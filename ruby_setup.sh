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

command_exists () {
    type "$1" &> /dev/null ;
}

if command_exists brew; then
    success_text "Homebrew detected, proceeding with installs"
else
    info_text "Brew is required to be installed!"
    if prompt_user "Would you like to install Homebrew?(y/n) "; then
        info_text "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        success_text "Homebrew installed"
    else
        info_text "Skipping installing Homebrew..."
        exit
    fi
fi

if prompt_user "Would you like to rbenv?"; then
    info_text "Installing rbenv..."
    brew install rbenv ruby-build
    rbenv install
    success_text "rbenv installed"
else
    info_text "Skipping installing rbenv..."
fi
