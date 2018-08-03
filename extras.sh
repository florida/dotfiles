#!/usr/bin/env bash
rbenv install 2.5.1
rbenv global 2.5.1

curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher

# curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash

gem install lolcat
gem update --system
fisher edc/bass
