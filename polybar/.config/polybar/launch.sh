#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

#for m in $(polybar --list-monitors | cut -d":" -f1); do
	#WIRELESS=$(ls /sys/class/net/ | grep ^wl | awk 'NR==1{print $1}') MONITOR=$m polybar --reload -l info mainbar-i3 &
#done
for i in $(polybar -m | awk -F: '{print $1}'); do MONITOR=$i polybar default & done

echo "Bars launched..."
