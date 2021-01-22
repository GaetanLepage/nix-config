#!/bin/sh

type pacman >/dev/null 2>&1 || exit

if ! updates_arch=$(checkupdates 2> /dev/null | wc -l ); then
    updates_arch=0
fi

if ! updates_aur=$(yay -Qum 2> /dev/null | wc -l); then
    updates_aur=0
fi

updates=$(("$updates_arch" + "$updates_aur"))

if [ "$updates" -gt 0 ]; then
    $TERMINAL --class update yay -Syu --noconfirm &
else
    echo "No updates"
    notify-send "No updates available"
fi
