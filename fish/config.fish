#!/usr/bin/env fish

# Base16 Shell
if status --is-interactive
#  eval sh $HOME/.config/term/base16-ocean.sh
end

function fish_prompt
  ~/.config/powerline-shell.py $status --shell bare ^/dev/null
  printf "\n\u276F "
end

set -x RBENV_HOME "$HOME/.rbenv"
set -x EDITOR vim

set PATH bin $PATH
set PATH $RBENV_HOME $PATH
set PATH $HOME/.rbenv/ $PATH
set PATH $HOME/.rbenv/shims $PATH
set PATH /usr/local/sbin $PATH

if which 'rbenv' >/dev/null ^&1
  # status --is-interactive; and . (rbenv init -|psub)
  echo 'eval "$(rbenv init -)"' | bash

  rbenv rehash >/dev/null ^&1
end

function git ; hub $argv ; end
