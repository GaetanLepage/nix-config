if [[ "$(tty)" = "/dev/tty1" ]]; then
	pgrep i3 || startx "$XDG_CONFIG_HOME/X11/xinitrc"
fi
