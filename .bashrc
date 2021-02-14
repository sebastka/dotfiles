#
#	Load ohmybash
#

if test -f /usr/share/oh-my-bash/bashrc; then
	. /usr/share/oh-my-bash/bashrc
fi

#
#	Env vars
#

# Locale
export LANG=en_US.UTF-8
export LC_ALL=nb_NO.UTF-8
export LC_TIME=$LANG

export EDITOR='nano'
export ARCHFLAGS="-arch x86_64"
export MAKEFLAGS="-j12"

#
#	Aliases
#

alias pmake='make $(MAKEFLAGS)'

#
#	kdesrc-build
#

## Add kdesrc-build to PATH
export PATH="$HOME/kde/src/kdesrc-build:$PATH"

## Run projects built with kdesrc-build
kdesrc-run () {
	source "$HOME/kde/build/$1/prefix.sh" && "$HOME/kde/usr/bin/${1##*/}" "${@:2:$#}"
}

#
#	Functions
#

if test -f ~/.bash_functions; then
	. ~/.bash_functions
fi

