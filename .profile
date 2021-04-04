#!/bin/sh
# Profile file. Runs on login

# Locale
export LANG="en_US.UTF-8"

# Custom scripts
[ -d "${HOME}/.scripts/" ] && export PATH="${PATH}:${HOME}/.scripts/"

# Software
export EDITOR='vim'
export TERMINAL='alacritty'

# GPG & SSH
export GPG_TTY="$(tty)"
[ -f "~/.ssh/id_${HOSTNAME}" ] && export SSH_KEY_PATH="~/.ssh/id_${HOSTNAME}"

# Load bashrc
[ -f ~/.bashrc ] && source ~/.bashrc

