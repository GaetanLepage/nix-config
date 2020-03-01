#!/bin/sh

HOSTNAME=$(hostname)

xrandr --output eDP1 --off
xrandr --output DP1 --off
xrandr --output DP1-1 --off
xrandr --output DP1-3 --off
xrandr --output DP2 --off
xrandr --output DP2-2 --off
xrandr --output DP2-3 --off
xrandr --output VIRTUAL1 --off

if [ "$HOSTNAME" == "gaetan-xps" ]
then
    BENQ="DP2-1"
    S144="DP1-2"
elif [ "$HOSTNAME" == "gaetan-pc" ]
then
    BENQ="DVI-D-0"
    S144="DP-0"
fi

xrandr --output $S144 --mode 1920x1080 --rate 144 --primary --pos 1920x0 --rotate normal
xrandr --output $BENQ --mode 1920x1080 --pos 0x0 --rotate normal



nmcli radio wifi off

# ~/.config/polybar/launch.sh
