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

write_banner "Welcome to your Command Line Tools and Terminal setup"

# XCode CLT install
if prompt_user "Would you like to install XCode Command Line Tools?(y/n) "; then
    info_text "Installing XCode Command Line Tools..."
    xcode-select --install
    success_text "XCode Command Line Tools installed"
else
    info_text "Skipping installing XCode Command Line Tools..."
fi

# Homebrew Install
if prompt_user "Would you like to install Homebrew?(y/n) "; then
    info_text "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    success_text "Homebrew installed"
else
    info_text "Skipping installing Homebrew..."
fi

# GnuGPG Install
if prompt_user "Would you like to install GNU GPG(y/n) "; then
    info_text "Installing GNU GPG..."
    brew install gnupg
    success_text "GNU GPG installed"
else
    info_text "Skipping installing GNU GPG..."
fi

# OhMyZsh install
## INSTALLING OhMyZsh
if prompt_user "Would you like to install OhMyZsh?(y/n) "; then
    info_text "Installing OhMyZsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    success_text "OhMyZsh installed"
else
    info_text "Skipping installing OhMyZsh..."
fi

# ZSH Powerline install
if prompt_user "Would you like to install ZSH Powerline?(y/n) "; then
    info_text "Installing ZSH Powerline..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    success_text "ZSH Powerline installed"
else
    info_text "Skipping installing ZSH Powerline..."
fi

if prompt_user "Would you like to install ZSH Autosuggestions?(y/n) "; then
    info_text "Installing ZSH Autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    success_text "ZSH Autosuggestions installed"
else
    info_text "Skipping installing ZSH Autosuggestions..."
fi

if prompt_user "Would you like to install ZSH Completions?(y/n) "; then
    info_text "Installing ZSH Completions..."
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
    success_text "ZSH Completions installed"
else
    info_text "Skipping installing ZSH Completions..."
fi

# Terminal login message removal setup
if prompt_user "Would you like to remove terminal login message?"; then
    info_text "Removing terminal login message..."
    touch .hushlogin
    success_text "Terminal login message removed"
else
    info_text "Skipping removing terminal login message..."
fi

# Lolcat install
if prompt_user "Would you like to install lolcat?"; then
    info_text "Installing lolcat..."
    brew install lolcat
    success_text "lolcat installed"
else
    info_text "Skipping installing lolcat..."
fi

write_banner "Command Line Tools and Terminal setup complete! Goodbye!"