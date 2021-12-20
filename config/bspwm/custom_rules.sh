#!/bin/sh

wid=$1
class=$2
instance=$3
consequences=$4

main() {
    # Debug: displays (with dunst) the class and instance of the opened window
    # notify-send "CLASS=$class INSTANCE=$instance"

    case "$class" in
        Spotify)
            echo "desktop=9"
            ;;
        Zotero)
            echo "desktop=7"
            ;;
        *py)
            echo "state=floating"
            ;;
        "")
            sleep 0.5

            wm_class=($(xprop -id $wid | grep "WM_CLASS" | grep -Po '"\K[^,"]+'))

            class=${wm_class[-1]}

            [[ ${#wm_class[@]} == "2" ]] && instance=${wm_class[0]}

            [[ -n $class ]] && main
            ;;
    esac
}

main
