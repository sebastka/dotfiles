#!/bin/sh -e
#  _               _
# | |             | |
# | |__   __ _ ___| |__  _ __ ___
# | '_ \ / _` / __| '_ \| '__/ __|
# | |_) | (_| \__ \ | | | | | (__
# |_.__/ \__,_|___/_| |_|_|  \___|
#

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# History file - infinite
HISTSIZE=HISTFILESIZE=

#
#	Set prompt
#

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}] "
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

function nonzero_return() {
	RETVAL=$?
	[ $RETVAL -ne 0 ] && echo "$RETVAL "
}

# Gruvbox dark: https://github.com/morhetz/gruvbox
RED="\[\033[38;5;167m\]"
GREEN="\[\033[38;5;142m\]"
YELLOW="\[\033[38;5;214m\]"
BLUE="\[\033[38;5;109m\]"
PURPLE="\[\033[38;5;175m\]"
AQUA="\[\033[38;5;108m\]"
GREY="\[\033[38;5;245m\]"

BG="\\033[38;5;235m"
FG0="\\033[38;5;229m"
ORANGE="\\033[38;5;166m"
WHITE="\\033[38;5;255m"

BOLD="\\033[01m"
STOP="\[\033[m\]"

PS1="${BOLD}${RED}\`nonzero_return\`${ORANGE}\[\u\]${GREY}@${FG0}\h ${BLUE}\[\W\] ${GREEN}\`parse_git_branch\`${STOP}\\$ "

#
#	Env vars
#

# GPG & SSH
export GPG_TTY=$(tty)
[ -f ~/.ssh/id_ed25519 ] && export SSH_KEY_PATH='~/.ssh/id_ed25519'

# MAKEFLAGS
[ -x "$(command -v nproc)" ] && export MAKEFLAGS="-j`nproc`"


#
#	Aliases
#

# Load uutils as aliases
if [ -x "$(command -v gen_uutils)" ]; then
	gen_uutils
	[ -f ~/.sh/uutils_aliases ] && . ~/.sh/uutils_aliases && rm ~/.sh/uutils_aliases
fi

alias make="make $MAKEFLAGS"
alias ls='ls -h --color=auto'
alias l='ls -alN --group-directories-first'
alias ss='sudo systemctl'
alias grep='grep --color=auto'
alias mkd='mkdir -pv'

#
#       kdesrc-build
#

if [ -d ~/kde/src/ ]; then
	## Add kdesrc-build to PATH
	export PATH="$HOME/kde/src/kdesrc-build:$PATH"

	## Run projects built with kdesrc-build
	kdesrc-run () {
		source "$HOME/kde/build/$1/prefix.sh" && "$HOME/kde/usr/bin/${1##*/}" "${@:2:$#}"
	}
fi
