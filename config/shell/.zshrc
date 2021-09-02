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

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  #source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

#######################
# Oh-my-zsh + plugins #
#######################

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="spaceship"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting autojump)

######################
# SSH agent and keys #
######################
# Gnome keyring daemon
if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK

else
# Else, use the OpenSSH default ssh-agent.

    # 1) Check whether an agent is running. If not, launch one.
    if ! pgrep -u "$USER" ssh-agent > /dev/null; then
        # echo "No ssh agent --> starting one"
        ssh-agent > "/tmp/ssh-agent.env"

        # Reset the environment variable
        SSH_AUTH_SOCK=''
    fi

    # Export the SSH_AUTH_SOCK variable.
    source "/tmp/ssh-agent.env" > /dev/null

    # If no key were added to the agent, look for some keys to add.
    ssh-add -l > /dev/null 2>&1
    if [ $? -ne 0 ] && [[ ! `hostname` =~ "^gpu.*|^node" ]]; then
        ssh-add $(grep -slR "PRIVATE" ~/.ssh/)
    fi
fi


###################
# STARTUP ROUTINE #
###################

# Source oh-my-zsh config
source $ZSH/oh-my-zsh.sh

# Launch neofetch
neofetch


##################
# Source configs #
##################

[[ ! -f $ZDOTDIR/inputrc ]] || source $ZDOTDIR/inputrc
[[ ! -f $ZDOTDIR/aliases ]] || source $ZDOTDIR/aliases


# To customize prompt, run `p10k configure` or edit ~/.dotfiles/.p10k.zsh.
[[ ! -f ~/.dotfiles/.p10k.zsh ]] || source ~/.dotfiles/.p10k.zsh

#########
# Conda #
#########
source init_conda


############
# Exputils #
############
# # define path to the exputils folder
# PATH_TO_EXPUTILS=$HOME/inria/software_tools/exputils
# if [ -f "$PATH_TO_EXPUTILS/commands/eu_setup.sh" ] ; then
#         . "$PATH_TO_EXPUTILS/commands/eu_setup.sh" "$PATH_TO_EXPUTILS"
# fi
# # set default project for exputils commands
# export EU_DEFAULT_PRJ=rlan
# # activate the default project
# source eu_activate
