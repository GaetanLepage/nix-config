#!/bin/sh

type pacman >/dev/null 2>&1 || exit

check_updates() {
    if ! updates_arch=$(checkupdates 2> /dev/null | wc -l ); then
        updates_arch=0
    fi

    if ! updates_aur=$(paru -Qum 2> /dev/null | wc -l); then
        updates_aur=0
    fi

    total_updates=$(("$updates_arch" + "$updates_aur"))
}

# Fetch updates
check_updates

case $1 in
    --check-updates)
        echo " $updates_arch |  $updates_aur"
        ;;

    --do-updates)
        if [ "$total_updates" -gt 0 ]; then
            $TERMINAL --class update update &
        else
            echo "No updates"
            dunstify "  No updates available"
        fi
        ;;

    *)
        dunstify "wrong argument"
        ;;
esac
