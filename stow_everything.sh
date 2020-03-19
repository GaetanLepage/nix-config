#!/usr/bin/env bash

# Do not include stow in that list. It is loaded beforehand anyways
apps="compton"`
     `" conky"`
     `" dunst"`
     `" git"`
     `" i3"`
     `" kitty"`
     `" mimeapps"`
     `" nvim"`
     `" p10k"`
     `" pavolume"`
     `" pcmanfm"`
     `" polybar"`
     `" profile"`
     `" scripts"`
     `" ranger"`
     `" wpg"`
     `" zathura"`
     `" zsh"
     #`" rofi"`

OPTS="--no-folding --verbose=1"

cd ~/.dotfiles

#stow $OPTS stow
for app in $apps
do
    stow $OPTS $app
done
