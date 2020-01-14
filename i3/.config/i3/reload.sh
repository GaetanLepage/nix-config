#!/bin/bash

xmodmap ~/.config/i3/swap_esc_capslock &
~/.config/i3/xrandr_auto.sh
sleep 1
nitrogen --restore
~/.config/polybar/launch.sh &
