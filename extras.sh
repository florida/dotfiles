#!/usr/bin/env bash

curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash

gem install lolcat