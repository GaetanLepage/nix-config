#!/usr/bin/env bash

# Do not include stow in that list. It is loaded beforehand anyways
apps="conky"`
     `" dunst"`
     `" flameshot"`
     `" fonts"`
     `" git"`
     `" gtk"`
     `" i3"`
     `" kitty"`
     `" lazygit"`
     `" mimeapps"`
     `" nvim"`
     `" p10k"`
     `" pavolume"`
     `" pcmanfm"`
     `" picom"`
     `" polybar"`
     `" profile"`
     `" scripts"`
     `" spotifyd"`
     `" ranger"`
     `" wallpaper"`
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
