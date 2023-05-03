#!/bin/sh

# DEPRECATED:
# As of 2023-04-11, I do not use this script as I run the polybar binary directly when launching
# bspwm.
# I keep this script around just in case.

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Loop through the connected monitors
polybar -m | while IFS= read -r line;do

    # Get the name of the monitor
    echo $line
    MONITOR=$(echo $line | cut -d: -f1)
    echo "Monitor = "$MONITOR

    # Detect if this monitor is the primary one
    IS_PRIMARY=$(echo $line | grep -Po '(?<=\().*(?=\))')
    if [[ $IS_PRIMARY ]] ; then
        TRAY_POS=right;
    else
        TRAY_POS=none ;
    fi

    # Launch the bar
    TRAY_POS=$TRAY_POS MONITOR=$MONITOR polybar bar -r &
done

echo "Bars launched"
