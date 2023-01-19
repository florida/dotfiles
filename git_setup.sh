#!/bin/bash

Color_Off='\033[0m'       # Text Reset

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow

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

setup_ssh() {
    local SSH_FILE=~/.ssh
    local SSH_CONFIG_FILE=~/.ssh/config

    if [ -f "$SSH_FILE" ]; then
        echo "$SSH_FILE exists!"
    else 
        echo "$SSH_FILE does not exist."
        bold_text "Enter your name and email to generate SSH key and git config"
        read -p "What's your github name? " GITHUB_NAME
        read -p "What's your github email? " GITHUB_EMAIL
        info_text "Generating a new SSH key & git config..."
        echo
        ssh-keygen -t ed25519 -C $GITHUB_EMAIL
        git config --global user.name $GITHUB_NAME
        git config --global user.email $GITHUB_EMAIL
        echo
        write_banner "SSH key and git config created"
    fi

    write_banner "Running ssh-agent in the background..."
    eval "$(ssh-agent -s)"

    if [ -f "$SSH_CONFIG_FILE" ]; then
        echo "$SSH_CONFIG_FILE exists!";
    else
        echo "$SSH_CONFIG_FILE does not exist!";
        info_text "Writing new SSH config...";
        echo "Host *.github.com\n  AddKeysToAgent yes\n  IdentityFile ~/.ssh/id_ed25519" >> $SSH_CONFIG_FILE
        success_text "SSH config created!"
    fi

    info_text "Adding SSH private key to ssh-agent..."; 
    ssh-add ~/.ssh/id_ed25519
    success_text "SSH private key was added!";

    ## SSH COPY PROMPT
    if prompt_user "Do you want to copy SSH public key?(y/n) "; then
        bold_text "Great! Copying SSH public key to clipboard";
        pbcopy < ~/.ssh/id_ed25519.pub
        echo
        bold_text "Copy your SSH public keys to https://github.com/settings/keys"
    else
        info_text Skipping copying SSH...;
        echo 
        bold_text "to manually copy SSH public key run:"
        echo
        echo "pbcopy < ~/.ssh/id_ed25519.pub"
        echo
    fi

    write_banner "SSH SETUP FINISHED!"
}

setup_gpg() {
    if which gpg >/dev/null; then
        success_text "gpg command exists!"
        generate_gpg_keys
    else
        info_text "gpg command does not exists"
        if prompt_user "Would you like to install GPG through homebrew?(y/n) "; then
            write_banner "GPG Installation"
            bold_text "Great! Let's install GPG installed";
            brew install gnupg
            write_banner "GPG Installation Complete"
            generate_gpg_keys
            write_banner "GPG Setup Complete"
        else
            write_banner "Skipping GPG install and setup..." $BYellow
        fi
    fi
}

generate_gpg_keys() {
    info_text "Generating GPG keys"
    gpg --full-generate-key
    success_text "Generated GPG keys successfully"
    bold_text "Displaying GPG keys"
    gpg --list-secret-keys --keyid-format=long
    read -p "Which long key would you like to export? " GPG_LONG_KEY
    gpg --armor --export $GPG_LONG_KEY
    bold_text "Copy your GPG public key to https://github.com/settings/keys"
}

write_banner "HI! WELCOME TO YOUR GIT SSH & GPG SETUP"

# Github CLI install
if prompt_user "Would you like to install Github CLI?(y/n) "; then
    info_text "Installing Github CLI..."
    brew install gh
    success_text "Github CLI installed"
else
    info_text "Skipping installing Github CLI..."
fi

## SSH SETUP PROMPT
if prompt_user "Do you want to setup SSH?(y/n) "; then
    write_banner "SSH SETUP"
    bold_text "Great! Let's get your SSH setup";
    setup_ssh
else
    write_banner "Aborting SSH Setup." $BRed
fi

## GPG SETUP PROMPT
if prompt_user "Do you want to start GPG Setup? "; then
    bold_text "Great! Let's get your GPG setup";
    write_banner "GPG SETUP"
    setup_gpg
else
    write_banner "Aborting GPG setup" $BRed;
fi

write_banner "SETUP FINISHED! Goodbye!"