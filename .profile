#!/bin/sh
# Profile file. Runs on login

[ -d "${HOME}/.scripts/" ] && export PATH="${PATH}:${HOME}/.scripts/"

# Env
export EDITOR='vim'
export TERMINAL='alacritty'

# Locale
export LANG="en_US.UTF-8"
export LC_ALL="nb_NO.UTF-8"
export LC_TIME="${LANG}"
export LC_CTYPE="${LANG}"

# GPG & SSH
export GPG_TTY="$(tty)"
[ -f "~/.ssh/id_${HOSTNAME}" ] && export SSH_KEY_PATH="~/.ssh/id_${HOSTNAME}"

# Load bashrc
[ -f ~/.bashrc ] && source ~/.bashrc

