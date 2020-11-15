# Other XDG paths
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}

# Disable files
export LESSHISTFILE=-

# Fixing Paths
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export XSERVERRC="$XDG_CONFIG_HOME"/X11/xserverrc
export GEM_PATH="$XDG_DATA_HOME/ruby/gems"
export GEM_SPEC_CACHE="$XDG_DATA_HOME/ruby/specs"
export GEM_HOME="$XDG_DATA_HOME/ruby/gems"
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export GOPATH="$XDG_DATA_HOME"/go
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export ZDOTDIR=$HOME/.config/zsh
#export HISTFILE="$XDG_DATA_HOME"/zsh/history
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export ZDOTDIR="$HOME"

# Scaling
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export QT_SCALE_FACTOR=1
export QT_SCREEN_SCALE_FACTORS="1;1;1"
export GDK_SCALE=1
export GDK_DPI_SCALE=1

# Default Apps
export BROWSER="firefox"
export CODEEDITOR="nvim"
export COLORTERM="truecolor"
export EDITOR="nvim"
export FILE="ranger"
export IMAGE="sxiv"
export OPENER="xdg-open"
export PAGER="less"
export READER="zathura"
export STATUSBAR="polybar"
export TERMINAL="kitty"
export VIDEO="mpv"
export VISUAL="nvim"
export WM="i3"

export CM_SELECTIONS="clipboard"
export CM_DEBUG=0
export CM_OUTPUT_CLIP=1
export CM_MAX_CLIPS=10

# Path
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/scripts:$PATH"

# Python PATH
export PYTHONPATH=$PYTHONPATH:/home/gaetan/hevs/implementations/object_detection/models

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Path for lcms2 (kitty dependency)
export PKG_CONFIG_PATH=~/.local/lib/pkgconfig/
