# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="agnoster"
ZSH_THEME=powerlevel10k/powerlevel10k


# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

export PYTHONPATH=$PYTHONPATH:/home/gaetan/hevs/implementations/object_detection/models

eval $(keychain --eval --quiet --noask ~/.ssh/rsa_gaetan_desktop_arch)

neofetch

echo "/!\\ do not talk about k!\n"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias l="ls -lFh"
alias ll="ls -alFh"
alias rm="rm -i"
alias cp="cp -i"
bindkey \^U backward-kill-line

# GIT
alias gs="git status"
alias gl="git log"
alias ga="git add"
alias gaa="git add *"
alias gc="git commit -m"
alias gca="git commit -am"
alias gd="git diff"
alias gpl="git pull"
alias gps="git push"
alias lg="lazygit"

alias code="code --disable-gpu"
alias c="cd"

alias vim="nvim"
alias vi="nvim"

alias spt="launch_spt"

alias z="zathura"
alias j="jobs"
alias r="ranger"

alias wttr="curl wttr.in/Dommartin+69380"

alias s="ack --python "
alias todo="s todo"
# count number of lines in Python project
alias cl="find . -name '*.py' | xargs wc -l"
alias pl="pylint ./**/*.py --extension-pkg-whitelist=cv2 --disable=C0413"

# wpgtk
# (cat $HOME/.config/wpg/sequences &)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
#bindkey -M menuselect 'h' vi-backward-char
#bindkey -M menuselect 'k' vi-up-line-or-history
#bindkey -M menuselect 'l' vi-forward-char
#bindkey -M menuselect 'j' vi-down-line-or-history
#bindkey -M menuselect 'left' vi-backward-char
#bindkey -M menuselect 'down' vi-down-line-or-history
#bindkey -M menuselect 'up' vi-up-line-or-history
#bindkey -M menuselect 'right' vi-forward-char
#bindkey -a u undo
#bindkey -a '^R' redo
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
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init

echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

