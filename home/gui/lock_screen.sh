#!/bin/sh

# Pause notifications
notifs_are_already_off=$(dunstctl is-paused)
# notifs_are_already_off='false'
# echo "Notifs were already off: $notifs_are_already_off"
# if [ $notifs_are_already_off = 'false' ]; then
#     echo -e "\nBlock notifications"
#     dunstctl set-paused true && echo "succesfully blocked ntofications"
# fi

# Pause any playing video / song
echo -e "\nPause any playing video/song"
playerctl pause

# Pause spotify
echo -e "\nPause spotify"
playerctl -p spotify pause

# Lock the screen
echo -e "\nLock screen"
betterlockscreen -l
