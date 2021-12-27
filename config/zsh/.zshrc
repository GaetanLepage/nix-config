# ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
# ██ ▄▄ █ ▄▄▀█ ▄▄█▄ ▄█ ▄▄▀█ ▄▄▀████ ████ ▄▄█▀▄▄▀█ ▄▄▀█ ▄▄▄█ ▄▄██
# ██ █▀▀█ ▀▀ █ ▄▄██ ██ ▀▀ █ ██ ████ ████ ▄▄█ ▀▀ █ ▀▀ █ █▄▀█ ▄▄██
# ██ ▀▀▄█▄██▄█▄▄▄██▄██▄██▄█▄██▄████ ▀▀ █▄▄▄█ ████▄██▄█▄▄▄▄█▄▄▄██
# ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀
# Website:  glepage.com
# GitHub:   https://github.com/GaetanLepage
# Email:    gaetan.lepage@inria.fr
#
# #-------#
# | zshrc |
# #-------#

# Components :
# *) shell = zsh
# *) plugin manager = oh-my-zsh
# *) theme = power-level-10k


# Enable colors
autoload -U colors && colors

export HISTFILE="$ZDOTDIR"/.zsh_history
# Path to your oh-my-zsh installation.
export ZSH=$ZDOTDIR/.oh-my-zsh

#######################
# Oh-my-zsh + plugins #
#######################

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="spaceship"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting autojump)

###################
# STARTUP ROUTINE #
###################

# Source oh-my-zsh config
source $ZSH/oh-my-zsh.sh

source $XDG_CONFIG_HOME/shell/shell_init

# Direnv
eval "$(direnv hook zsh)"
