#!/bin/sh -e

# Profile file. Runs on login

export PATH=$PATH:$HOME/.sh/
export EDITOR='vim'
export TERMINAL='alacritty'

# Locale
export LANG="en_US.UTF-8"
export LC_ALL="nb_NO.UTF-8"
export LC_TIME=$LANG
export LC_CTYPE=$LANG

[ -f ~/.bashrc ] && source ~/.bashrc
