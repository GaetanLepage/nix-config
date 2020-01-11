#!/bin/sh

HOSTNAME=$(hostname)

disable_all () {
    xrandr --output eDP1 --off
    xrandr --output DP1 --off
    xrandr --output DP1-1 --off
    xrandr --output DP1-3 --off
    xrandr --output DP2 --off
    xrandr --output DP2-2 --off
    xrandr --output DP2-3 --off
    xrandr --output VIRTUAL1 --off
}

dual_screen () {
    # $1 : Main screen (144Hz)
    # $2 : Second screen (BenQ)
    xrandr --output $1 --mode 1920x1080 --rate 144 --primary --pos 1920x0 --rotate normal
    xrandr --output $2 --mode 1920x1080 --pos 0x0 --rotate normal
}



# Start by disabling all outputs
disable_all


# Desktop PC
if [ "$HOSTNAME" == "gaetan-pc" ]
then
    S144="DP-0"
    BENQ="DVI-D-0"
    dual_screen "$S144" "$BENQ"

# Laptop
elif [ "$HOSTNAME" == "gaetan-xps" ]
then
    LAPTOP_SCREEN=""
    S144="DP1-2"
    BENQ="DP2-1"

    # Laptop only
    if [ #TODO ]
    then
        xrandr

    # External only
    elif []
    then
        EXTERNAL=""

    # Dual screen
    elif []
    then

    fi
fi




nmcli radio wifi off

# ~/.config/polybar/launch.sh
