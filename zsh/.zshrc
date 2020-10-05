###################
# Gaetan's .zshrc #
###################

# Components :
# *) shell = zsh
# *) plugin manager = oh-my-zsh
# *) theme = power-level-10k


#########
# PATHS #
#########

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/home/galepage/.config/nvm/versions/node/v14.4.0/bin/:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.local/share/flatpak/exports/bin:$PATH

# Python PATH
export PYTHONPATH=$PYTHONPATH:/home/gaetan/hevs/implementations/object_detection/models

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Path for lcms2 (kitty dependency)
export PKG_CONFIG_PATH=~/.local/lib/pkgconfig/

export EDITOR=nvim


#######################
# Oh-my-zsh + plugins #
#######################

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="agnoster"
ZSH_THEME=powerlevel10k/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

#######
# NVM #
#######
# export NVM_DIR="$HOME/.config//nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#
# export NODE_PATH=~/.local/bin/node

###################
# STARTUP ROUTINE #
###################

# Source oh-my-zsh config
source $ZSH/oh-my-zsh.sh

# Launch neofetch
neofetch
echo "/!\\ do not talk about k!\n"

###########
# ALIASES #
###########

alias l="ls -lFh"
alias ll="ls -alFh"
alias rm="rm -i"
alias cp="cp -i"
bindkey \^U backward-kill-line

# GIT
alias lg="lazygit"
alias gs="git status"
alias gl="git log"
alias ga="git add"
alias gaa="git add *"
alias gc="git commit -m"
alias gca="git commit -am"
alias gd="git diff"
alias gpl="git pull"
alias gps="git push"

alias c="cd"

alias vim="nvim"
alias vi="nvim"
alias v="nvim"

# Spotif tui
alias spt="launch_spt"

alias z="zathura"
alias j="jobs"
alias r="ranger"

# Weather forecast
alias wttr="curl wttr.in/Dommartin+69380"

# Search within project
alias s="ack --python "
alias todo="s TODO"
# count number of lines in Python project
alias cl="find . -name '*.py' | xargs wc -l"
alias pl="pylint ./**/*.py --extension-pkg-whitelist=cv2 --disable=C0413"

alias apt="sudo apt-get"


###########
# VI MODE #
###########

bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
#bindkey -M menuselect 'left' vi-backward-char
#bindkey -M menuselect 'down' vi-down-line-or-history
#bindkey -M menuselect 'up' vi-up-line-or-history
#bindkey -M menuselect 'right' vi-forward-char
#bindkey -a u undo
#bindkey -a '^R' redo
bindkey "^R" history-incremental-search-backward
#bindkey '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select


zle-line-init() {
    # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    zle -K viins
    echo -ne "\e[5 q"
}
zle -N zle-line-init

# Use beam shape cursor on startup.
echo -ne '\e[5 q'
# Use beam shape cursor for each new prompt.
preexec() { echo -ne '\e[5 q' ;}
