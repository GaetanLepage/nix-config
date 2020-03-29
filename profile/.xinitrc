#!/bin/sh

# xinitrc runs automatically when you run startx.

# There are some small but important commands that need to be run when we start
# the graphical environment. I keep those commands in ~/.xprofile because that
# file is run automatically if someone uses a display manager (login screen)
# and so they are needed there. To prevent doubling up commands, I source them
# here with the line below.


echo "$(date) : START .xinitrc" >> /home/gaetan/log_start.txt

[ -f ~/.xprofile ] && . ~/.xprofile

# Starting i3
exec dbus-launch i3;

echo "$(date) : END .xinitrc" >> /home/gaetan/log_start.txt
