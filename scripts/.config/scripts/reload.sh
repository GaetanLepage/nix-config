#!/bin/bash

setxkbmap -option caps:swapescape
~/.config/i3/xrandr_auto.sh
sleep 1
nitrogen --restore
~/.config/polybar/launch.sh &
