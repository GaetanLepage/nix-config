#!/bin/sh
xrandr --output eDP1 --off --output DP1 --off --output DP1-1 --off --output DP1-2 --mode 1920x1080 --rate 144 --primary --pos 1920x0 --rotate normal --output DP1-3 --off --output DP2 --off --output DP2-1 --mode 1920x1080 --pos 0x0 --rotate normal --output DP2-2 --off --output DP2-3 --off --output VIRTUAL1 --off

nmcli radio wifi off

~/.config/polybar/launch.sh
