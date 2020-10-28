neofetch

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

set -o vi

# Source configs
for f in ~/.config/shellconfig/*; do source "$f"; done
source /home/brodie/.config/broot/launcher/bash/br
