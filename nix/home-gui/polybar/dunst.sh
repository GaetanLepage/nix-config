#!/bin/sh

source $XDG_CONFIG_HOME/polybar/helper.sh

if [ "$(dunstctl is-paused)" == "true" ]; then
    print_line "  " $RED
else
    # print_line "  " $GREEN
    echo "  "
fi
