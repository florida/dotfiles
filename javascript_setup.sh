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

# NVM Install
if [ -f "$NVM_DIR" ]; then
    source "${NVM_DIR}/nvm.sh"
    info_text "NVM already installed"
else
    if prompt_user "Would you like to install nvm?(y/n) "; then
        info_text "Installing nvm..."
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
        success_text "nvm installed"
    else
        info_text "Skipping installing nvm..."
    fi
fi

if prompt_user "Would you like to install Node with nvm?(y/n) "; then
    info_text "Installing Node..."
    nvm install node
    success_text "Node installed"
else
    info_text "Skipping installing Node..."
fi
