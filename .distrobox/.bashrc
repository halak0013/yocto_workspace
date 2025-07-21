# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Append to the history file, don't overwrite it
shopt -s histappend

# Check the window size after each command and, if necessary, Update the values of LINES and COLUMNS.
shopt -s checkwinsize

export PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
export HISTCONTROL=erasedups
export HISTSIZE=10000000
export HISTFILESIZE=10000000

export WORKDIR="${WORKDIR:-/home/yocto_hane}"
export BANNER="$HOME/.motd"
export YOCTO_LABS_DIR="$HOME/yocto-labs"
export PS1='🌪️ distrobox:\[\033[01;34m\]\W\[\033[00m\]> '

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


oldpwd=$(pwd)
source $HOME/yocto-labs/poky/oe-init-build-env
cd $oldpwd

if [ -f $BANNER ]; then
    cat $BANNER
fi