#!/bin/sh
# Profile file. Runs on login

# Locale
export LANG="en_US.UTF-8"

# Env
[ -z "${HOSTNAME}" ] && export HOSTNAME="$(hostname)"
[ -z ${HOST} ] && export HOST="${HOSTNAME}"

export TERM=st-256color
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1

# Custom scripts
[ -d "${HOME}/.scripts/" ] && export PATH="${PATH}:${HOME}/.scripts/"

# Software
export EDITOR='vim'
export TERMINAL='alacritty'

# GPG & SSH
export GPG_TTY="$(tty)"
SSH_KEY_PATH="~/.ssh/${USER}@${HOSTNAME}"
[ -f "${SSH_KEY_PATH}" ] && export SSH_KEY_PATH

# Load shell config rc
. ~/.MYSHELLrc
